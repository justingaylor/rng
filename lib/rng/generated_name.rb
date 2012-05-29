require 'rng/name'

module Rng
  class GeneratedName < Name
    attr_accessor :source_names
    
    def initialize(name, sources)
      super(name)
      @source_names = sources
    end
  end
end