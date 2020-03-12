def process_file(file, outfile, dryrun = nil, file_op = 'cp')
  if dryrun
    puts "pretending to #{file_op} \"#{file} to #{outfile}\""
  else
    puts "#{file_op}-ing \"#{file} to #{outfile}\"..."
    FileUtils.public_send(file_op, file, outfile)
    FileUtils.public_send(file_op, "#{file}.xmp", outfile, force: true)
    if file_op == 'cp'
      FileUtils.public_send(file_op, "#{file}.xmp", outfile)
    else
      FileUtils.public_send(file_op, "#{file}.xmp", outfile, force: true)
    end
  end
end

def copy_pic(file, outfile, destpath, dryrun = nil, file_op = 'cp')
  if File.exist?(outfile)
    puts "\"#{outfile}\" already exists. Skipping..."
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
