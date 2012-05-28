module Rng
  class GeneratedName < Name
    def initialize(name, sources)
      super(name)
      @sources = sources
    end

    def SourceNames
      @sources
    end

  end
end