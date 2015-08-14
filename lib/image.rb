require "rmagick"
require "open-uri"

class Image
  def initialize(url)
    @url = url
    @image = rmagick_image
  end

  def is_gravatar?
    colors <= 2 && width < 450 && height < 450
  end

  def colors
    @image.color_histogram.keys.count
  end

  def width
    @image.columns
  end

  def height
    @image.rows
  end

  private

  def raw_image
    open(@url).read
  end

  def rmagick_image
    Magick::Image.from_blob(raw_image).first
  end
end
