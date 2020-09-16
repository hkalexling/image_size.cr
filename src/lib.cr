@[Link(ldflags: "-L#{__DIR__}/../ext/stbi/ -lstbi")]
lib LibStbi
  fun stbi_info_from_memory(buffer : LibC::UChar*, size : LibC::SizeT, width : LibC::Int*, height : LibC::Int*, component : LibC::Int*) : LibC::Int
  fun stbi_load_from_memory(buffer : LibC::UChar*, size : LibC::SizeT, width : LibC::Int*, height : LibC::Int*, component : LibC::Int*, request_component : LibC::Int) : LibC::UChar*
  fun stbir_resize_uint8(buffer : LibC::UChar*, width : LibC::Int, height : LibC::Int, stride : LibC::Int, output : LibC::UChar*, output_width : LibC::Int, output_height : LibC::Int, output_stride : LibC::Int, channels : LibC::Int) : LibC::Int
  fun stbi_image_free(Void*)
  fun stbi_write_jpg_memory(width : LibC::Int, height : LibC::Int, component : LibC::Int, data : LibC::UChar*, quality : LibC::Float, output : LibC::UChar**) : LibC::Int
end

@[Link(ldflags: "-L#{__DIR__}/../ext/libwebp/ -lwebp")]
lib LibWebP
  fun WebPGetInfo(data : LibC::UInt8T*, size : LibC::SizeT, width : LibC::Int*, height : LibC::Int*) : LibC::Int
  fun WebPDecodeRGB(data : LibC::UInt8T*, size : LibC::SizeT, width : LibC::Int*, height : LibC::Int*) : LibC::UInt8T*
  fun WebPResizeRGB(data : LibC::UInt8T*, width : LibC::Int, height : LibC::Int, stride : LibC::Int, target_width : LibC::Int, target_height : LibC::Int, quality : LibC::Float, output : LibC::UInt8T**) : LibC::SizeT
end
