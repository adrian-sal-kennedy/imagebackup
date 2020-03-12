require 'csv'

class FileTypes
  def self.list
    file_list = []
    CSV.foreach("#{File.dirname(__FILE__)}/filetypes.csv") do |csv|
      file_list << "**/*.#{csv[0]}"
      file_list << "**/*.#{csv[0].upcase}"
    end
    return file_list
  end

  def self.add(ext=nil,type=nil)
    unless ext 
      puts 'please enter the file type\'s extension, with or without the dot.'
      ext = gets.strip
    end
    unless type
      puts 'please enter "movie" or "pic" so we know what we\'re working with.'
      type = gets.strip
    end
    ext = ext.to_s.gsub(/[*."]/,'')
    p type
    type = (type.downcase.include?('m')) ? "movie" : "pic"
    puts "opening file \"#{File.dirname(__FILE__)}/filetypes.csv\""
    CSV.open("#{File.dirname(__FILE__)}/filetypes.csv","a") do |csv|
      p csv << [ext,type]
    end
    puts "New file types registered."
    exit
  end
end
