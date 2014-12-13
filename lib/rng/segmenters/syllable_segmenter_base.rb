module Rng
  module SyllableSegmenterBase

    def self.included base
      base.extend ClassMethods
    end

    module ClassMethods
      def init_syllable_matching(initials, inners, finals)
        # Initialize the list of valid initial sounds
        init_longest_matching(initials)

        # Initialize the list of valid inner (vowel) sounds
        init_longest_matching(inners)

        # Initialize the list of valid final sounds
        init_longest_matching(finals)
      end

      def extract_first_syllable(name)
        initial = inner = final = ''
        name = name.downcase

        initials.each do |s|
          if name.index(s) == 0
            # Save the initial
            initial = s
            # Remove the sound from the beginning of the name
            name = name[s.length..-1]
            break
          end
        end

        inners.each do |s|
          if name.index(s) == 0
            # Save the inner
            inner = s
            # Remove the sound from the beginning of the name
            name = name[s.length..-1]
            break
          end
        end

        finals.each do |s|
          if name.index(s) == 0
            # Save the final
            final = s
            # Remove the sound from the beginning of the name
            name = name[s.length..-1]
            break
          end
        end

        return Syllable.new(initial, inner, final)
      end

      def extract_last_syllable(name)
        initial = inner = final = ''
        name = name.downcase

        finals.each do |s|
          if name.rindex(s) == name.length - s.length
            # Save the final
            final = s
            # Remove the sound from the beginning of the name
            name = name[0..-s.length-1]
            break
          end
        end

        inners.each do |s|
          if name.rindex(s) == name.length- s.length
            # Save the inner
            inner = s
            # Remove the sound from the beginning of the name
            name = name[0..-s.length-1]
            break
          end
        end

        initials.each do |s|
          if name.rindex(s) == name.length - s.length
            # Save the final
            initial = s
            # Remove the sound from the beginning of the name
            name = name[0..-s.length-1]
            break
          end
        end

        return Syllable.new(initial, inner, final)
      end

      def init_longest_matching(sounds)
        sounds.sort! do |a,b|
          if a == ''
            1
          elsif b == ''
            -1
          else
            (b.length <=> a.length)
          end
        end
      end

      def init_shortest_matching(sounds)
        sounds.sort! do |a,b|
          if a == ''
            1
          elsif b == ''
            -1
          else
            (a.length <=> b.length)
          end
        end
      end
    end

  end
end