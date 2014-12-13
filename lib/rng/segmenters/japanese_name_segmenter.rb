require_relative 'syllable_segmenter_base'

module Rng
  module Segmenters
    module JapaneseNameSegmenter
      include Rng::SyllableSegmenterBase

      # Array for initial sounds in syllables
      @initials = ['b', 'ch', 'd', 'f', 'g', 'h', 'j', 'k'] +
                  ['m', 'n', "n'", 'r', 's', 'sh', 't', 'ts', 'w', 'y', 'z']

      # Array for inner sounds in syllables
      @inners  = ['']

      # Array for final sounds in syllables
      @finals  = ['a', 'i', 'u', 'e', 'o', '']

      # Initialize the module
      init_syllable_matching(initials, inners, finals)
    end
  end
end