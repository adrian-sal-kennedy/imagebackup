def build_paths(dest,file,date)
  date = get_dates(file)
  destpath = "#{dest}/#{date}"
  destpath = destpath.gsub('//','/')
  outfile =  "#{destpath}/#{File.basename(file)}"
  return [outfile,destpath]
end