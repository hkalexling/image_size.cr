libstbi.a: stbi.o
	ar rcs libstbi.a stbi.o

stbi.o: stb_image.c stb_image.h
	gcc -c stb_image.c -o stbi.o

stb_image.h:
	wget https://raw.githubusercontent.com/nothings/stb/master/stb_image.h

clean:
	rm -f stb_image.h *.a *.o *.so
