require "./spec_helper"

describe ImageSize do
  it "reads JPEG file" do
    size = ImageSize.get "spec/test.jpg"
    size.width.should eq 550
    size.height.should eq 368
  end

  it "reads WebP file" do
    size = ImageSize.get "spec/test.webp"
    size.width.should eq 550
    size.height.should eq 368
  end

  it "resizes JPEG file by width" do
    bytes = ImageSize.resize "spec/test.jpg", width: 100
    size = ImageSize.get bytes
    size.width.should eq 100
    size.height.should eq 67
  end

  it "resizes JPEG file by height" do
    bytes = ImageSize.resize "spec/test.jpg", height: 100
    size = ImageSize.get bytes
    size.width.should eq 149
    size.height.should eq 100
  end

  it "resizes JPEG file by both width and height" do
    bytes = ImageSize.resize "spec/test.jpg", width: 100, height: 100
    size = ImageSize.get bytes
    size.width.should eq 100
    size.height.should eq 100
  end

  it "resizes WebP file by width" do
    bytes = ImageSize.resize "spec/test.webp", width: 100
    size = ImageSize.get bytes
    size.width.should eq 100
    size.height.should eq 67
  end

  it "resizes WebP file by height" do
    bytes = ImageSize.resize "spec/test.webp", height: 100
    size = ImageSize.get bytes
    size.width.should eq 149
    size.height.should eq 100
  end

  it "resizes WebP file by both width and height" do
    bytes = ImageSize.resize "spec/test.webp", width: 100, height: 100
    size = ImageSize.get bytes
    size.width.should eq 100
    size.height.should eq 100
  end
end
