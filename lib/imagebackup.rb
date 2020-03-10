#!/usr/bin/env ruby
require_relative 'imagebackup/version'

# require_relative ''

require 'exiv2'
require 'fileutils'
require 'ffprober'
require 'json'

def file_types_list
  return [
    '**/*.CR2',
    '**/*.DNG',
    '**/*.MOV',
    '**/*.MP4',
    '**/*.JPG'
  ]
end

def get_dates(file)
  begin
    image = Exiv2::ImageFactory.open(file)
    image.read_metadata
    date = image.exif_data.find { |v| v[0] == 'Exif.Image.DateTime' }
    date = date[1].split[0].gsub(':','-')
  rescue => exiv2_no_exifdata
    probe = Ffprober::Parser.from_file(file)
    date = probe.format.tags[:creation_time].split('T')[0]
  end
  return date
end

# dest = ARGV[0]

def main_loop(dest)
  file_types = file_types_list()
  Dir.glob(file_types).reverse_each do |f|

    file = "#{Dir.pwd}/#{f}"

    date = get_dates(file)
    destpath = "#{dest}/#{date}"
    destpath = destpath.gsub('//','/')
    outfile =  "#{destpath}/#{File.basename(file)}"
    if File.exist?(outfile)
      puts "\"#{outfile}\" already exists."
    else
      puts "copying \"#{file}\" to \"#{outfile}\""
      puts "FileUtils.mkdir_p(#{destpath})"
      puts "FileUtils.cp(#{file},#{outfile})"
    end
  end
end

main_loop(ARGV[0])