all : libfoo.a libfoo.so

libfoo.a: foo.o
	ar rcs $@ $^

libfoo.so: foo.o
	$(CC) -shared -o $@ $^

foo.o: foo.c
	$(CC) -c -o $@ $^


