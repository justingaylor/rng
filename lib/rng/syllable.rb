module Rng
  class Syllable
    attr_reader :initial, :inner, :final
    
    def initialize(initial, inner, final='')
      @initial = initial.downcase
      @inner = inner.downcase
      @final = final.downcase
    end

    def to_s
      return @initial + @inner + @final
    end
  end
end