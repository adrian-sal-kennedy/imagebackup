#!/usr/bin/env ruby
require_relative 'imagebackup/version'

require_relative 'classes/filetypes'
require_relative 'methods/build_paths'
require_relative 'methods/get_dates'
require_relative 'methods/copy_pic'

require 'exiv2'
require 'fileutils'
require 'ffprober'
require 'json'
require 'getoptlong'

def main_loop(dest,dryrun=true)
  file_types = FileTypes.list
  Dir.glob(file_types).reverse_each do |f|

    file = "#{Dir.pwd}/#{f}"

    parms = build_paths(dest,file,get_dates(file))
    outfile = parms[0]
    destpath = parms[1]

    if File.exist?(outfile)
      puts "\"#{outfile}\" already exists."
    else
      copy_pic(file,outfile,destpath,dryrun)
    end
  end
end

# main_loop(ARGV[0])

dryrun = true

if (ARGV & ['-n','--dry-run']).any?
  dryrun = true
  ARGV.delete('-n')
  ARGV.delete('--dry-run')
else
  # FIXME: THIS IS REVERSED TO ALWAYS BE TRUE WHILE I'M TESTING. CHANGE BELOW TO false BEFORE DEPLOYMENT
  dryrun = true
  puts "dry run is disabled! i'm really going to mess with your files!"
end
if ARGV.include?('-a')#,'--add-filetype']).any?
  ext=ARGV[ARGV.index('-a')+1]
  type=ARGV[ARGV.index('-a')+2]
  ARGV.slice!(ARGV.index('-a')..ARGV.index('-a')+2)
end
if ARGV.include?('--add-filetype')
  ext=ARGV[ARGV.index('--add-filetype')+1]
  type=ARGV[ARGV.index('--add-filetype')+2]
  ARGV.slice!(ARGV.index('--add-filetype')..ARGV.index('--add-filetype')+2)
end
if ext
  FileTypes.add(ext,type)
end

if ARGV
  main_loop(ARGV[0])
end