require_relative 'syllable_segmenter_base'

module Rng
  module Segmenters
    module FantasyNameSegmenter
      include Rng::SyllableSegmenterBase

      $initials = [
        'b', 'br', 'bh', 'bl',
        'c', 'cr', 'ch', 'cl', 'chr',
        'd', 'dr', 'dw',
        'f', 'fr', 'fl',
        'g', 'gr', 'gl', 'gw', 'gh',
        'h',
        'j',
        'k', 'kr', 'kh',
        'l', 'll',
        'm',
        'n',
        'p', 'ph', 'pr',
        'q', 'qu',
        'r',
        's', 'sh', 'sl',
        't', 'th', 'tr', 'thr',
        'v', 'vh',
        'w',
        'x',
        'y',
        'z',
        ''
      ]

      $inners = [
        'a', 'ae', 'ai', 'au', 'aa',
        'e', 'eo', 'ei', 'ea', 'ee',
        'i',
        'o', 'oo',
        'u', 'uu',
        'y'
      ]

      $finals = [
        'b',
        'c', 'ch',
        'd',
        'f',
        'g', 'gh',
        'h',
        'j',
        'k', 'kh',
        'l', 'ld', 'lm', 'lf', 'll', 'lth',
        'm', 'mm', 'msh',
        'n', 'nn', 'nd', 'nt', 'ng',
        'p', 'ph',
        'q',
        'r', 'rd', 'rn', 'rm', 'rk', 'rl', 'rth',
        's', 'sh', 'st', 'ss', 'sk',
        't', 'th', 'tz',
        'v',
        'w', 'wn',
        'x',
        'y',
        'z', 'zzt',
        ''
      ]

      # Array for initial sounds in syllables
      def self.initials
        $initials
      end

      # Array for inner sounds in syllables
      def self.inners
        $inners
      end

      # Array for final sounds in syllables
      def self.finals
        $finals
      end

      def self.segment(name)
        beginning = []
        ending = []

        orig_name = name = name.downcase

        passes = 0
        while name != ''
          # TODO: If more than one pass and no change (not 50 pass limit)
          raise Rng::SegmentError.new(orig_name, name) unless passes < 50

          # Extract the last syllable
          last = [extract_last_syllable(name)]

          # Add the new syllable to the front of ending (we are working backward from the ending)
          ending = last + ending

          # Remove the last syllable from the name string
          name = name[0..-last[0].to_s.length-1]

          # If there was only one syllable, we are done
          if name == ''
            break
          end

          # Extract the first syllable
          first = [extract_first_syllable(name)]

          # Add the new syllable to the end of beginning (we are working forward from the beginning)
          beginning = beginning + first

          # Remove the first syllable from the name string
          #name = (name.length == first[0].to_s.length ? '' : name[first[0].to_s.length..-1])
          name = name[first[0].to_s.length..-1]

          passes +=1
        end

        return (beginning + ending)
      end

      init_syllable_matching(initials, inners, finals)
    end
  end
end