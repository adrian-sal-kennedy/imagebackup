def copy_pic(file,outfile,destpath,dryrun)
  if dryrun
    puts "pretending to copy \"#{file}\" to \"#{outfile}\""
    puts "FileUtils.mkdir_p(#{destpath})"
    puts "FileUtils.cp(#{file},#{outfile})"
  else
    puts "copying \"#{file}\" to \"#{outfile}\""
    FileUtils.mkdir_p(destpath)
    FileUtils.cp(file,outfile)
  end
end
