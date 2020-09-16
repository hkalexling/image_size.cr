libwebp.a: objects/libwebp.a
	mv objects/libwebp.a .

objects/libwebp.a: objects/enc.o objects/libwebp.o
	cd objects && ar rcs libwebp.a *.o

objects/enc.o: objects/libwebp.o
	cd objects && ar x ../libwebp-1.1.0/src/libwebp.a

objects/libwebp.o: libwebp.o
	mkdir -p objects
	mv libwebp.o objects

libwebp.o: libwebp-1.1.0/src/libwebp.a libwebp.h libwebp.c
	gcc -c libwebp.c -L./libwebp-1.1.0/src/libwebp.a -o libwebp.o

libwebp-1.1.0/src/libwebp.a: libwebp-1.1.0/makefile.unix
	cd libwebp-1.1.0 && make -f makefile.unix

libwebp-1.1.0/makefile.unix: v1.1.0.tar.gz
	tar -xvf v1.1.0.tar.gz
	@touch $@

v1.1.0.tar.gz:
	wget https://github.com/webmproject/libwebp/archive/v1.1.0.tar.gz

clean:
	rm -rf v1.1.0.tar.gz libwebp-1.1.0 libwebp.a objects
