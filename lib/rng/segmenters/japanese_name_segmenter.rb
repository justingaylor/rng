require_relative 'syllable_segmenter_base'

module Rng
  module Segmenters
    module JapaneseNameSegmenter
      include Rng::SyllableSegmenterBase

      # Array for initial sounds in syllables
      initials = ['b', 'ch', 'd', 'f', 'g', 'h', 'j', 'k'] +
                 ['m', 'n', "n'", 'r', 's', 'sh', 't', 'ts', 'w', 'y', 'z']

      # Array for inner sounds in syllables
      inners  = ['']

      # Array for final sounds in syllables
      finals  = ['a', 'i', 'u', 'e', 'o', '']

      # Initialize the module
      init_syllable_matching(initials, inners, finals)

      def self.extract_last_syllable(name)
        initial = inner = final = ''

        $finals.each do |fin|
          # If the name ends with this 'final' sound || it is empty
          if fin == name[-fin.size..-1] || fin == ''
            no_final = name[0..-fin.size-1]
            $inners.each do |inn|
              if inn == ''
                no_inner = no_final[0..-inn.size-1]
                $initials.each do |ini|
                  if ini == no_inner[-ini.size..-1] || ini == ''
                    return Syllable.new(ini, inn, fin)
                  end
                end
              end
            end
          end
        end

        raise "Couldn't extract a last syllable for '#{name}'."
      end

      def self.extract_first_syllable(name)
        #initial = inner = final = ''

        $initials.each do |ini|
          # If the name ends with this 'final' sound || it is empty
          if ini == name[ini.size-1] || ini == ''
            no_initial =  name[ini.size..-1]
            $inners.each do |inn|
              if inn == ''
                no_inner = no_initial[inn.size..-1]
                $finals.each do |fin|
                  if fin == no_inner[fin.size-1] || fin == ''
                    return Syllable.new(ini, inn, fin)
                  end
                end
              end
            end
          end
        end

        raise "Couldn't extract a last syllable for '#{name}'."
      end
    end
  end
end