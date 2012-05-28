require 'syllable_segmenter'
require 'name_file_loader'
require 'syllable_stats'
require 'generated_name'

module Rng
  class NameGenerator


    def initialize(filename)
      # Load the file containing the list of names
      loader = RngNameFileLoader.new
      @names = loader.load(filename)

      # Dump the names loaded
      #self.dump_names

      # Crunch the necessary statistics about syllable relationships
      #statistics = RngSyllableStats.new(@names)
    end

    def generate(n, max_chars, algorithm = :VERY_SIMPLE)
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

    def generate_name(max_len, algorithm = :VERY_SIMPLE)
      # Determine which algorithm to use to generate the name
      if algorithm == :VERY_SIMPLE
        return generate_name_very_simple(max_len)
      elsif algorithm == :SIMPLE
        return generate_name_simple(max_len)
      else
        return generate_name_bayesian(max_len)
      end
    end

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
        beginning = name.Syllables[0].to_s.capitalize
        if beginning.length < max_len
          source_names << name.Name
          break
        end
      end

      # Select an ending syllable
      count = 0
      loop do
        ending = ''
        name   = @names[rand(@names.length)]
        ending = name.Syllables[name.Syllables.length-1].to_s
        if (beginning + ending).length < max_len
          source_names << name.Name
          break
        end
        count += 1
        break unless count <= 100
      end

      name = RngGeneratedName.new(remove_reps(beginning + ending).capitalize, source_names)

      return name.Name
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
        beginning = name.Syllables[0].to_s.capitalize
        if beginning.length < max_len
          source_names << name.Name
          break
        end
      end

      # Select an ending syllable
      count = 0
      loop do
        ending = ''
        name   = @names[rand(@names.length)]
        ending = name.Syllables[name.Syllables.length-1].to_s
        if (beginning + ending).length < max_len
          source_names << name.Name
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
        num_interm = rand(1)
        num_interm.times do
          name = @names[rand(@names.length)]
          temp_source_names << name.Name
          middle += name.Syllables[rand(name.Syllables.length)].to_s
        end
        if remove_reps((beginning + middle + ending)).length <= max_len
          source_names += temp_source_names
          break
        end
      end

      name = RngGeneratedName.new(remove_reps(beginning + middle + ending).capitalize, source_names)

      return name.Name
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