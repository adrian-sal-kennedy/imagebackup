def process_file(file, outfile, dryrun = nil, file_op = 'cp')
  if dryrun
    puts "#{"pretending to ".colorize(:light_green)}#{file_op} \"#{file}#{" to ".colorize(:light_green)}#{outfile}\""
  else
    puts "#{file_op}-ing \"#{file} to #{outfile}\"..."
    FileUtils.public_send(file_op, file, outfile)
    if File.exist?("#{file}.xmp")
      FileUtils.public_send(file_op, "#{file}.xmp", "#{outfile}.xmp")
    end
  end
end

def copy_pic(file, outfile, destpath, dryrun = nil, file_op = 'cp')
  if File.exist?(outfile)
    puts "\"#{outfile}\" #{"already exists. Skipping...".colorize(:light_blue)}."
  else
    unless dryrun
      unless File.exist?(destpath)
        puts "creating folder \"#{destpath}\""
        FileUtils.mkdir_p(destpath)
      end
    end
    process_file(file, outfile, dryrun, file_op)
  end
end
