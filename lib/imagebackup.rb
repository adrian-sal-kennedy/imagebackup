require_relative 'imagebackup/version'

require 'exiv2'
file_types = [
  '**/*.CR2',
  '**/*.DNG',
  '**/*.MOV',
  '**/*.MP4'
]
Dir.glob(file_types).each do |f|
  puts "#{Dir.pwd}/#{f}"
  file = "#{Dir.pwd}/#{f}"
  image = Exiv2::ImageFactory.open(file)
  image.read_metadata
  # p image.iptc_data.each do |k,v|
  #   puts "#{k} = #{v}\n"
  # end
  # p date = image.exif_data.member?("Exif.Image.DateTime")
  p date = image.exif_data.find do |v|
    # puts k.to_str
    # puts v.to_str
  end
  gets
end