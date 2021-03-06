# frozen_string_literal: true

def build_paths(dest, file, date)
  date = get_dates(file)
  destpath = "#{dest}/#{date}"
  destpath = destpath.gsub('//', '/')
  outfile =  "#{destpath}/#{File.basename(file)}"
  [outfile, destpath]
end
