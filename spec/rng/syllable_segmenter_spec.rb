require 'rng/syllable_segmenter'


describe Rng::SyllableSegmenter do
  it "can segment single syllable names" do
    syllables = Rng::SyllableSegmenter.segment("Thor")
    syllables.should_not be_nil
    syllables.should be_an(Array)
    syllables.size.should == 1
    syllables[0].to_s.should == "thor"
  end
  
  it "can segment double syllable names" do
    syllables = Rng::SyllableSegmenter.segment("Thorin")
    syllables.should_not be_nil
    syllables.should be_an(Array)
    syllables.size.should == 2
    syllables[0].to_s.should == "tho"
    syllables[1].to_s.should == "rin"
  end
  
  it "can segment triple syllable names" do
    syllables = Rng::SyllableSegmenter.segment("Mephisto")
    syllables.should_not be_nil
    syllables.should be_an(Array)
    syllables.size.should == 3
    syllables[0].to_s.should == "meph"
    syllables[1].to_s.should == "is"
    syllables[2].to_s.should == "to"
  end
  
  it "can segment loooooooooooong names" do
    syllables = Rng::SyllableSegmenter.segment("Mephistopheles")
    syllables.should_not be_nil
    syllables.should be_an(Array)
    syllables.size.should == 5
    syllables[0].to_s.should == "meph"
    syllables[1].to_s.should == "ist"
    syllables[2].to_s.should == "o"
    syllables[3].to_s.should == "phe"
    syllables[4].to_s.should == "les"
  end
  
end