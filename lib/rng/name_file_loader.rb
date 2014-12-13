
module Rng
  class NameFileLoader
    attr_reader :segmenter

    def initialize(segmenter=Rng::Segmenters::FantasySyllableSegmenter)
      reinitialize(segmenter)
    end

    def load(path)
      reinitialize(segmenter)

      raise Rng::FileLoadError.new("File '#{path}' does not exist.") unless File.exists?(path)

      # Open the file
      count = 0
      @file = File.new(path, File::RDONLY)
      @file.readlines.each do |line|
        tokens = line.chomp.strip.split(',')
        name = tokens[0]
        if name != '' && name != 'Name'
          name = Name.new(name.downcase.capitalize, segmenter)
          puts name.syllables.collect(&:to_s).join(", ")
          @names << name
        end
      end

      # Close the file
      @file.close

      return @names.sort {|a,b| a.name <=> b.name}
    end

    private

    def reinitialize(segmenter)
      @names = []
      @file = nil
      @segmenter = segmenter
    end
  end
end