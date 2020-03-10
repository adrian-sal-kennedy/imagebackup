#!/usr/bin/env ruby
require_relative 'imagebackup/version'

require 'exiv2'

file_types = [
  '**/*.CR2',
  '**/*.DNG',
  '**/*.MOV',
  '**/*.MP4',
  '**/*.JPG'
]

dest = ARGV[0]

Dir.glob(file_types).each do |f|
  # puts "#{Dir.pwd}/#{f}"
  file = "#{Dir.pwd}/#{f}"
  image = Exiv2::ImageFactory.open(file)
  image.read_metadata
  
  date = image.exif_data.find { |v| v[0] == 'Exif.Image.DateTime' }
  destpath = "#{dest}/#{date[1].split[0].gsub(':','-')}"
  destpath = destpath.gsub('//','/')
  if Dir.exist?(destpath)
    p outfile =  "#{destpath}/#{File.basename(file)}"
  else
    puts "nope, \"#{destpath}\" doesn't exist."
  end
  sleep 1
end