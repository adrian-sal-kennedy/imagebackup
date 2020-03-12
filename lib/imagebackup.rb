#!/usr/bin/env ruby
require_relative 'imagebackup/version'

require_relative 'classes/filetypes'
require_relative 'methods/build_paths'
require_relative 'methods/get_dates'
require_relative 'methods/copy_pic'
require_relative 'methods/display_help'

require 'exiv2'
require 'fileutils'
require 'ffprober'

def main_loop(dest,dryrun=true,file_op="copy")#,move=nil,link=nil)
  file_types = FileTypes.list
  Dir.glob(file_types).reverse_each do |f|

    file = "#{Dir.pwd}/#{f}"

    parms = build_paths(dest,file,get_dates(file))
    outfile = parms[0]
    destpath = parms[1]

    copy_pic(file,outfile,destpath,dryrun,file_op)#,move,link)
    
  end
end

# main_loop(ARGV[0])

dryrun = true
# link = false
# move = false
file_op = "cp" # or "mv" or "ln_s"

if (ARGV & ['-m','--move']).any?
  # move = true
  file_op = "mv"
  ARGV.delete('-m')
  ARGV.delete('--move')
end
if (ARGV & ['-l','--link']).any?
  # link = true
  file_op = "ln_s"
  ARGV.delete('-l')
  ARGV.delete('--link')
end
if ARGV.include?('-a')
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
if (ARGV & ['-n','--dry-run']).any?
  dryrun = true
  puts "Doing a dry run - no operations will happen."
  sleep 1
  ARGV.delete('-n')
  ARGV.delete('--dry-run')
else
  dryrun = false
end

if (ARGV & ['-h','--help','-?']).any?
  display_help()
end

if ARGV[0].to_s == ''
  display_help()
else
  if File.exist?(ARGV[0])
    main_loop(ARGV[0],dryrun,file_op)
  else
    puts "Specified destination does not exist. Please create this folder first."
  end
end