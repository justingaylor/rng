require 'name.rb'
require 'syllable_stats.rb'

module Rng
  class Statistics
    #------------
    # Methods
    #------------
    def initialize
      @syllable_stats = Array.new
    end

    def process(names)
      self.extract_syllables(names)

      @syllable_stats.each do |syllable|
        syllable.update names
      end

      print 'done'

  #    i=1
  #    @syllable_stats.each do |syllable|
  #      puts i.to_s + ': ' + syllable.Syllable
  #      i += 1
  #    end
    end

    def extract_syllables(names)
      # Loop through the names, appending all syllables
      # in the list of syllables if they are not present
      names.each do |name|
        name.Syllables.each do |syllable|
          if not @syllable_stats.index(syllable)
            @syllable_stats << syllable
          end
        end
      end

      # Convert the list of string to a list of syllable stat objects
      @syllable_stats.map! {|syllable| RngSyllableStats.new(syllable)}

      # Sort the syllable stat list for fun
      @syllable_stats.sort! {|a,b| a.Syllable <=> b.Syllable}
    end

    def calculateProbabilities(names)
      # For each syllable, check calculate the probabilities for it
      @syllable_stats.each do |syllable|

      end
    end

    #------------------
    # Property Getters
    #------------------

    #------------------
    # Property Setters
    #------------------

  end
end