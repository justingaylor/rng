module Rng
  class SyllableStats
    def initialize(names)
      # This hash maps a character to the probability that this syllable was preceded
      # by a syllable ending with that character
      @prev_prob = {}

      # This hash maps a character to the probability that this syllable was followed
      # by a syllable beginning with that character
      @post_prob = {}

      # This hash maps a character to the probability that this syllable was preceded
      # by a syllable ending with that character
      init_hash_table @prev_prob

      # This hash maps a character to the probability that this syllable was followed
      # by a syllable beginning with that character
      init_hash_table @post_prob

      # Calculate the probabilities for the inter-syllable relationships
      calculate_probabilities(names)
    end

    def init_hash_table(hash_table)
      # Create an empty hash table
      hash_table.replace({})

      # For each letter the alphabet, create a key for it and set the value to zero
      for i in (0..25)
        hash_table[(?a + i).chr.to_s] = 0
      end
    end

    def calculate_probabilities(names)
      create_syllable_list(names)
      update_prev_prob(names)
      update_post_prob(names)
    end

    def update_prev_prob(names)
      # Reinitialize the hash table
      init_hash_table(@prev_prob)

      # Build a list of names that have this syllable is them
      trimmed_names = (names.map {|name| name.Syllables.index(@syllable) ? name : nil}).compact!

      # Create a hash table to count the previous prob for each letter in the alphabet
      prev_prob_count = {}
      init_hash_table(prev_prob_count)

      # For each name that contains this syllable, increment the counter for the appropriate letter
      trimmed_names.each do |name|
        # Find out what place this syllable is in the name
        index = name.Syllables.index(@syllable)

        # If it is not the first syllable
        if index != 0
          # Get the last letter of the previous syllable
          letter = name.Syllables[index-1][-1].chr.to_s
          prev_prob_count[letter] += 1
        end
      end

      # Calculate the total number of counts in the prev prob table
      total_count = 0
      prev_prob_count.each_key {|key| total_count += prev_prob_count[key]}

      # Compute the probabilities
      @prev_prob.each_key {|key| @prev_prob[key] = (prev_prob_count[key].to_f/total_count.to_f) }
    end

    def update_post_prob(names)
      # Reinitialize the hash table
      init_hash_table(@post_prob)

      # Build a list of names that have this syllable is them
      trimmed_names = (names.map {|name| name.Syllables.index(@syllable) ? name : nil}).compact!

      # Create a hash table to count the previous prob for each letter in the alphabet
      post_prob_count = {}
      init_hash_table(post_prob_count)

      # For each name that contains this syllable, increment the counter for the appropriate letter
      trimmed_names.each do |name|
        # Find out what place this syllable is in the name
        index = name.Syllables.index(@syllable)

        # If it is not the last syllable
        if index != name.Syllables.length-1
          # Get the first letter of the following syllable
          letter = name.Syllables[index+1][0].chr.to_s
          post_prob_count[letter] += 1
        end
      end

      # Calculate the total number of counts in the prev prob table
      total_count = 0
      post_prob_count.each_key {|key| total_count += post_prob_count[key]}

      # Compute the probabilities
      @post_prob.each_key {|key| @post_prob[key] = (post_prob_count[key].to_f/total_count.to_f) }
    end
  
    def create_syllable_list(names)
    
    end
  end
end