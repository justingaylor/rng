
module Rng
  class GeneratedName < Name
    attr_accessor :source_names

    def initialize(name, sources, segmenter)
      super(name, segmenter)
      @source_names = sources
    end
  end
end