def get_dates(file)
  begin
    image = Exiv2::ImageFactory.open(file)
    image.read_metadata
    date = image.exif_data.find { |v| v[0] == 'Exif.Image.DateTime' }
    date = date[1].split[0].gsub(':', '-')
  rescue StandardError
    begin
      probe = Ffprober::Parser.from_file(file)
      date = probe.format.tags[:creation_time].split(/[T ]/)[0]
    rescue StandardError
      fileobj = File.new(file)
      date = "#{"%04d" % fileobj.stat.ctime.year}-#{"%02d" % fileobj.stat.ctime.month}-#{"%02d" % fileobj.stat.ctime.day}"
    end
  end
  date
end
