require 'json'

class JsonReaderWriter

  def self.read_file(json_file)
    if json_file.include?('.json')
      file = File.read(json_file)
      begin
        JSON.parse(file, symbolize_names: true)
      rescue JSON::ParserError
        puts "Malformed json."
        nil
      end
    else
      puts "Bad file type."
      nil
    end
  end

  def self.export_to_file(export_data)
    File.open("output.json", "w") do |f|
      f.write(JSON.pretty_generate(export_data))
    end
  end
end
