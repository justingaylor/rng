module Rng
  module SyllableSegmenterBase

    def self.included base
      base.extend ClassMethods
    end

    $initials = $inners = $finals = []

    module ClassMethods
      def init_syllable_matching(initials, inners, finals)
        $initials = initials.clone
        $inners = inners.clone
        $finals = finals.clone

        # Initialize the list of valid initial sounds
        init_longest_matching($initials)

        # Initialize the list of valid inner (vowel) sounds
        init_longest_matching($inners)

        # Initialize the list of valid final sounds
        init_longest_matching($finals)
      end

      def segment(name)
        beginning = []
        ending = []

        orig_name = name = name.downcase

        passes = 0
        while name != ''
          raise Rng::SegmentError.new(orig_name, name) unless passes < 50

          # Extract the last syllable
          last = [extract_last_syllable(name)]

          # Add the new syllable to the front of ending (we are working inward from the ending)
          ending = last + ending

          # Remove the last syllable from the name string
          name = name[0..-last[0].to_s.length-1]

          # If there was only one syllable, we are done
          if name == ''
            break
          end

          # Extract the first syllable
          first = [extract_first_syllable(name)]

          # Add the new syllable to the end of beginning (we are working inward from the beginning)
          beginning = beginning + first

          # Remove the first syllable from the name string
          #name = (name.length == first[0].to_s.length ? '' : name[first[0].to_s.length..-1])
          name = name[first[0].to_s.length..-1]

          passes +=1
        end

        return (beginning + ending)
      end

      def extract_first_syllable(name)
        initial = ''
        inner = ''
        final = ''

        $initials.each do |s|
          if name.index(s) == 0
            # Save the initial
            initial = s
            # Remove the sound from the beginning of the name
            name = name[s.length..-1]
            break
          end
        end

        $inners.each do |s|
          if name.index(s) == 0
            # Save the inner
            inner = s
            # Remove the sound from the beginning of the name
            name = name[s.length..-1]
            break
          end
        end

        $finals.each do |s|
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
        initial = ''
        inner = ''
        final = ''

        $finals.each do |s|
          if name.rindex(s) == name.length - s.length
            # Save the final
            final = s
            # Remove the sound from the beginning of the name
            name = name[0..-s.length-1]
            break
          end
        end

        $inners.each do |s|
          if name.rindex(s) == name.length- s.length
            # Save the inner
            inner = s
            # Remove the sound from the beginning of the name
            name = name[0..-s.length-1]
            break
          end
        end

        $finals.each do |s|
          if name.rindex(s) == name.length - s.length
            # Save the final
            final = s
            # Remove the sound from the beginning of the name
            name = name[0..-s.length-1]
            break
          end
        end

        return Syllable.new(initial, inner, final)
      end

      def init_longest_matching(sounds)
        #binding.pry if self.name == "Rng::Segmenters::JapaneseSyllableSegmenter"
        sounds.sort! do |a,b|
          if a == ''
            1
          elsif b == ''
            -1
          else
            (b.length <=> a.length)
          end
        end
        #binding.pry if self.name == "Rng::Segmenters::JapaneseSyllableSegmenter"
        #true
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