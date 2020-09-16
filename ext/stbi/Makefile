libstbi.a: stbi.o
	ar rcs libstbi.a stbi.o

stbi.o: stb_image.c stb_image.h stb_image_resize.h stb_image_write.h stb_image_custom.h
	gcc -c stb_image.c -o stbi.o

stb_image.h:
	wget https://raw.githubusercontent.com/nothings/stb/master/stb_image.h

stb_image_resize.h:
	wget https://raw.githubusercontent.com/nothings/stb/master/stb_image_resize.h

stb_image_write.h:
	wget https://raw.githubusercontent.com/nothings/stb/master/stb_image_write.h

clean:
	rm -f stb_image.h stb_image_resize.h stb_image_write.h *.a *.o *.so
