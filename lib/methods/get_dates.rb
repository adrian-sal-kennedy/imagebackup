def get_dates(file)
  begin
    image = Exiv2::ImageFactory.open(file)
    image.read_metadata
    date = image.exif_data.find { |v| v[0] == 'Exif.Image.DateTime' }
    date = date[1].split[0].gsub(':','-')
  rescue => exiv2_no_exifdata
    begin
      probe = Ffprober::Parser.from_file(file)
      date = probe.format.tags[:creation_time].split('T')[0]
    rescue => invalid_or_corrupt_file
      fileobj = File.new(file)
      date = "#{fileobj.stat.ctime.year}-#{fileobj.stat.ctime.month}-#{fileobj.stat.ctime.day}"
    end
  end
  return date
end