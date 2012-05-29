require 'rng/name'

module Rng
  class NameFileLoader
    def initialize
      @names = []
    end

    def load(path)
      if not File.exists?(path)
        puts 'File ' + path + ' does not exist.'
        @file = nil
        return nil
      end

      # Open the file
      @file = File.new(path, File::RDONLY)

      # Construct an array of name objects
      @names = []
      @file.each_line do |line|
        tokens = line.chomp.strip.split ','
        if tokens[0] != '' and tokens[0] != 'Name'
          name = Name.new(tokens[0].downcase.capitalize)
          @names << name
        end
      end

      # Close the file
      @file.close

      return @names.sort {|a,b| a.name <=> b.name}
    end
  end
end