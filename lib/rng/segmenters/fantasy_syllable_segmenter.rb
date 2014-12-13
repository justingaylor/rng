require_relative 'syllable_segmenter_base'

module Rng
  module Segmenters
    module FantasySyllableSegmenter
      include Rng::SyllableSegmenterBase

      # Array for initial sounds in syllables
      initials = ['b', 'br', 'bh', 'bl'] +
                 ['c', 'cr', 'ch', 'cl', 'chr'] +
                 ['d', 'dr', 'dw'] +
                 ['f', 'fr', 'fl'] +
                 ['g', 'gr', 'gl', 'gw', 'gh'] +
                 ['h'] +
                 ['j'] +
                 ['k', 'kr', 'kh'] +
                 ['l', 'll'] +
                 ['m'] +
                 ['n'] +
                 ['p', 'ph', 'pr'] +
                 ['q', 'qu'] +
                 ['r'] +
                 ['s', 'sh', 'sl'] +
                 ['t', 'th', 'tr', 'thr'] +
                 ['v', 'vh'] +
                 ['w'] +
                 ['x'] +
                 ['y'] +
                 ['z'] +
                 ['']

      # Array for inner sounds in syllables
      inners  = ['a', 'ae', 'ai', 'au', 'aa'] +
                ['e', 'eo', 'ei', 'ea', 'ee'] +
                ['i'] +
                ['o', 'oo'] +
                ['u', 'uu'] +
                ['y']

      # Array for final sounds in syllables
      finals = ['b'] +
               ['c', 'ch'] +
               ['d'] +
               ['f'] +
               ['g', 'gh'] +
               ['h'] +
               ['j'] +
               ['k', 'kh'] +
               ['l', 'ld', 'lm', 'lf', 'll', 'lth'] +
               ['m', 'mm', 'msh'] +
               ['n', 'nn', 'nd', 'nt', 'ng'] +
               ['p', 'ph'] +
               ['q'] +
               ['r', 'rd', 'rn', 'rm', 'rk', 'rl', 'rth'] +
               ['s', 'sh', 'st', 'ss', 'sk'] +
               ['t', 'th', 'tz'] +
               ['v'] +
               ['w', 'wn'] +
               ['x'] +
               ['y'] +
               ['z', 'zzt'] +
               ['']

      init_syllable_matching(initials, inners, finals)
    end
  end
end