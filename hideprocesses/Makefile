all: process.so

libprocesshider.so: processhider.c
	gcc -Wall -fPIC -shared -o process.so processhider.c -ldl

.PHONY clean:
	rm -f process.so
