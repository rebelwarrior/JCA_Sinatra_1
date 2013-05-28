module ImageChecker
  require 'fastimage'
  
  def slideshow_images_same_size?(location='public/images/slideshow', dimensions=[123,456])
     #Note: the Dir.glob will return nil if not specified correctly.
     acc = []
     Dir.glob("#{location}/*.{png,jpg}").sort.each do |file|
        acc << FastImage.size(file)
     end
     # puts acc.uniq
     acc.uniq.size == 1
  end

end

module ImageFixer
  def resize_image
    #pending
  end
end
