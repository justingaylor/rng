module Rng
  module SyllableSegmenter
    # Array for initial sounds in syllables
    $initials = ['b', 'br', 'bh', 'bl'] +
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
    $inners  = ['a', 'ae', 'ai', 'au', 'aa'] +
               ['e', 'eo', 'ei', 'ea', 'ee'] +
               ['i'] +
               ['o', 'oo'] +
               ['u', 'uu'] +
               ['y']

    # Array for final sounds in syllables
    $finals  = ['b'] +
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

    def self.init_syllable_matching
      # Initialize the list of valid initial sounds
      init_longest_matching($initials)

      # Initialize the list of valid inner (vowel) sounds
      init_longest_matching($inners)

      # Initialize the list of valid final sounds
      init_longest_matching($finals)
    end

    def self.segment(name)
      beginning = []
      ending = []

      name = name.downcase

      while name != ''
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
      end

      return (beginning + ending)
    end

    def self.extract_first_syllable(name)
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

    def self.extract_last_syllable(name)
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

      $initials.each do |s|
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

    def self.init_longest_matching(sounds)
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

    def self.init_shortest_matching(sounds)
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


  # Initialize the module
  SyllableSegmenter.init_syllable_matching
end