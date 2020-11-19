libbill.so: libbill.c
	gcc -shared -o libbill.so libbill.c
clean:
	rm libbill.so
