# SPDX-License-Identifier: MIT
# Copyright (c) 2019 Intel Corporation
# All rights reserved.
import os
import atexit
import asyncio
import subprocess


class SimulatorFailedToStart(Exception):
    pass  # pragma: no cov


class Simulator:

    HOST = "127.0.0.1"
    PORT = 2321
    PPORT = 2322

    def __init__(self, binary="tpm2-simulator", host=None, port=None, pport=None):
        self.binary = binary
        self.host = host if host is not None else self.HOST
        self.port = port if port is not None else self.PORT
        self.pport = pport if pport is not None else self.PPORT
        self.proc = None

    async def _create_connection_after(self, loop, delay):
        await asyncio.sleep(delay, loop=loop)
        try:
            reader, writer = await asyncio.open_connection(
                self.host, self.port, loop=loop
            )
            writer.close()
            return True
        except Exception as error:
            # Don't raise connection errors, return false if we didn't connect
            return False

    async def _stagger_create_connections(self, loop, timeout, stagger=0.05):
        complete = False
        # Stagger the creation of connections
        tasks = set(
            [
                loop.create_task(self._create_connection_after(loop, delay * stagger))
                for delay in range(0, int(timeout / stagger))
            ]
        )
        try:
            while tasks:
                done, pending = await asyncio.wait(
                    tasks, return_when=asyncio.FIRST_COMPLETED, loop=loop
                )
                # Check if the done coroutines that finished raised exceptions
                for task in done:
                    failed = task.exception()
                    if failed is not None:
                        raise failed
                complete = any([task.result() for task in done])
                if complete:
                    break
        finally:
            # Cancel all unconnected coroutines
            for task in tasks:
                if not task.done():
                    task.cancel()
        return complete

    async def _connect_to_simulator(self, loop, timeout):
        done, pending = await asyncio.wait(
            [loop.create_task(self._stagger_create_connections(loop, timeout))],
            timeout=timeout,
            loop=loop,
        )
        # If none are done then we got a timeout
        if not done:
            raise TimeoutError(
                "Could not connect to simulator within {} seconds".format(timeout)
            )
        # Cancel all unconnected coroutines
        for task in pending:
            task.cancel()
        # Check if the done coroutines that finished raised exceptions
        for task in done:
            failed = task.exception()
            if failed is not None:
                raise failed

    def connect_to_simulator(self, timeout):
        loop = asyncio.new_event_loop()
        loop.run_until_complete(self._connect_to_simulator(loop, timeout))
        loop.close()

    def start(self, timeout=2):
        # Remove simulator state if it exists
        if os.path.isfile("NVChip"):
            os.unlink("NVChip")
        # We are setting up a simulator in here, because we require the standard
        # ports. pytpm2tss does not yet support setting tctis and thus relies on
        # esys to do so.
        async def doit():
            self.proc = await asyncio.create_subprocess_exec(
                self.binary,
                "0",
                "-m",
                stdout=subprocess.PIPE,
                stderr=subprocess.STDOUT,
                start_new_session=True,
            )
            atexit.register(self.stop)

            tasks = set()

            exited = asyncio.create_task(self.proc.wait())
            tasks.add(exited)

            readline = asyncio.create_task(self.proc.stdout.readline())
            tasks.add(readline)

            done = set()

            print()
            print()
            print(tasks)
            print()

            while exited not in done:

                done, _pending = await asyncio.wait(
                    tasks, return_when=asyncio.FIRST_COMPLETED
                )

                if readline in done:
                    line = readline.result()
                    print(line)
                    if line.startswith("TPM command server listening on port"):
                        self.port = int(line.split()[-1])
                    elif line.startswith("Platform server listening on port"):
                        self.pport = int(line.split()[-1])
                        break
            try:
                self.connect_to_simulator(timeout)
            except TimeoutError as error:
                raise SimulatorFailedToStart(self.output) from error
            if self.proc.poll() is not None:
                raise SimulatorFailedToStart(self.output)

        loop = asyncio.get_event_loop()
        try:
            loop.run_until_complete(doit())
        finally:
            loop.close()

    @property
    def output(self):
        if self.proc is not None:
            stderr, stdout = self.proc.communicate()
            return "{}\n{}".format(stderr.decode(), stdout.decode()).strip()
        return "Not running"

    def stop(self):
        atexit.unregister(self.stop)
        if self.proc is not None:
            # self.proc.stdout.close()
            self.proc.terminate()
            os.waitpid(self.proc.pid, 0)
            self.proc = None


class SimulatorTest:
    """
    Testcase that requires the tpm_server simulator to be running.
    """

    def setUp(self):
        super().setUp()
        self.simulator = Simulator()
        if not os.getenv("SIM_RUNNING", default=""):
            self.simulator.start()

    def tearDown(self):
        super().tearDown()
        if not os.getenv("SIM_RUNNING", default=""):
            self.simulator.stop()
