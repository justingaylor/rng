
module Rng
  class Name
    attr_accessor :syllables

    def initialize(name)
      # Using the setter method because it segments syllables
      self.name = name
    end

    def raw_name
      @syllables.join('/').capitalize
    end

    def name
      @name
    end

    def name=(name)
      # Segment the name into its component syllables
      @syllables = SyllableSegmenter.segment(name)
      @syllables.map! { |s| Syllable.new(s.initial, s.inner, s.final) }

      # Set the name
      @name = name
    end

    def to_s
      self.name
    end

    def length
      self.name.length
    end
  end
end