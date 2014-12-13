module Rng
  class Generator
    def initialize(filename, segmenter=Rng::Segmenters::FantasyNameSegmenter)
      # Load the file containing the list of names
      loader = NameFileLoader.new(segmenter)
      @names = loader.load(filename)

      @segmenter = segmenter

      # Dump the names loaded
      #self.dump_names

      # Crunch the necessary statistics about syllable relationships
      #statistics = RngSyllableStats.new(@names)
    end

    def generate(n, max_chars=15, algorithm=:very_simple)
      names = []
      for i in 1..n
        name = "-" * (max_chars+1)
        while name.length > max_chars
          name = generate_name(max_chars, algorithm)
        end
        names << name
      end
      return names
    end

    def generate_name(max_len, algorithm = :very_simple)
      # Determine which algorithm to use to generate the name
      if algorithm == :very_simple
        return generate_name_very_simple(max_len)
      elsif algorithm == :simple
        return generate_name_simple(max_len)
      else
        return generate_name_bayesian(max_len)
      end
    end

    # Generates names exactly two syllables long
    #
    def generate_name_very_simple(max_len)
      source_names = []
      beginning = ''
      ending    = ''

      # Validate maximum length
      if max_len < 2
        max_len = 2
      end

      # Select a beginning syllable
      loop do
        name = @names[rand(@names.length)]
        beginning = name.syllables[0].to_s.capitalize
        if beginning.length < max_len
          source_names << name.name
          break
        end
      end

      # Select an ending syllable
      count = 0
      loop do
        ending = ''
        name   = @names[rand(@names.length)]
        ending = name.syllables[name.syllables.length-1].to_s
        if (beginning + ending).length < max_len
          source_names << name.name
          break
        end
        count += 1
        break unless count <= 100
      end

      name = GeneratedName.new(remove_reps(beginning + ending).capitalize, source_names, @segmenter)

      return name
    end

    def generate_name_simple(max_len)
      source_names = []
      beginning = ''
      middle    = ''
      ending    = ''

      # Validate maximum length
      if max_len < 2
        max_len = 2
      end

      # Select a beginning syllable
      loop do
        name = @names[rand(@names.length)]
        beginning = name.syllables[0].to_s.capitalize
        if beginning.length < max_len
          source_names << name.name
          break
        end
      end

      # Select an ending syllable
      count = 0
      loop do
        ending = ''
        name   = @names[rand(@names.length)]
        ending = name.syllables[name.syllables.length-1].to_s
        if (beginning + ending).length < max_len
          source_names << name.name
          break
        end
        count += 1
        break unless count <= 100
      end

      # Generate zero or more intermediate syllables
      loop do
        middle = ''
        temp_source_names = []
        # Determine the number of syllables intermediate syllables
        num_interm = rand(4)
        num_interm.times do
          name = @names[rand(@names.length)]
          temp_source_names << name.name
          middle += name.syllables[rand(name.syllables.length)].to_s
        end
        if remove_reps((beginning + middle + ending)).length <= max_len
          source_names += temp_source_names
          break
        end
      end

      name = GeneratedName.new(remove_reps(beginning + middle + ending).capitalize, source_names)

      return name
    end

    def generate_name_bayesian(max_chars)
      return generate_name_simple(max_chars)
    end

    def remove_reps(s)
      result = s
      result.gsub!("ll", "")
      result.gsub!("nn", "")
      return result
    end

    def dump_names
      # Display a table heading
      puts "-"*(16) + ' ' + "-"*(16)
      puts " Name".ljust(16) + ' ' + " RawName".ljust(16)
      puts "-"*(16) + ' ' + "-"*(16)
      @names.each do |name|
        print name.Name.ljust(16) + ' ' + name.RawName.ljust(16)
        puts ''
      end
    end

    def dump_syllables
      # Construct a list of all unique syllables identified
      syllables = []
      @names.each do |name|
        name.Syllables.each {|syllable| syllables << syllable.to_s}
      end
      syllables.uniq!
      syllables.sort!

      count = 1
      syllables.each do |syllable|
        puts "#{count}".rjust(4) + ": " + "#{syllable}"
        count += 1
      end
    end

  end
end