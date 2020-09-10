libwebp.a: libwebp-1.1.0/src/libwebp.a
	cp libwebp-1.1.0/src/libwebp.a .

libwebp-1.1.0/src/libwebp.a: libwebp-1.1.0/makefile.unix
	cd libwebp-1.1.0 && make -f makefile.unix

libwebp-1.1.0/makefile.unix: v1.1.0.tar.gz
	tar -xvf v1.1.0.tar.gz
	@touch $@

v1.1.0.tar.gz:
	wget https://github.com/webmproject/libwebp/archive/v1.1.0.tar.gz

clean:
	rm -rf v1.1.0.tar.gz libwebp-1.1.0 libwebp.a
