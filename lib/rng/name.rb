require 'syllable'
require 'syllable_segmenter'

class RngName
  #------------
  # Methods
  #------------
  def initialize(name)
    self.Name = name
  end

  #------------------
  # Property Getters
  #------------------
  def Syllables
    @syllables
  end
  def Name
    @name
  end
  def RawName
    # Set the raw name
    raw_name = ''
    @syllables.each {|syllable| raw_name += syllable.to_s.downcase + '/'}
    return raw_name.capitalize[0..-2]
  end

  #------------------
  # Property Setters
  #------------------
  def Name=(name)
    # Set the name
    @name = name

    # Segment the name into its component syllables
    syllables = RngSyllableSegmenter.segment @name

    # Set the syllables
    @syllables = []
    syllables.each {|s| @syllables << RngSyllable.new(s.Initial, s.Inner, s.Final) }
  end
end