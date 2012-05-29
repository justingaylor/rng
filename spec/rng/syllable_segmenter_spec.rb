require 'rng/syllable_segmenter'


describe Rng::SyllableSegmenter do
  it 'can segment single syllable names' do
    syllables = Rng::SyllableSegmenter.segment('Thor')
    syllables.should_not be_nil
    syllables.should be_an(Array)
    syllables.size.should == 1
  end
  
  it 'segments double syllable names' do
    syllables = Rng::SyllableSegmenter.segment('Thorin')
    syllables.should_not be_nil
    syllables.should be_an(Array)
    syllables.size.should == 2
  end
  
  it 'segments triple syllable names' do
    syllables = Rng::SyllableSegmenter.segment('Mephisto')
    syllables.should_not be_nil
    syllables.should be_an(Array)
    syllables.size.should == 3
  end
  
  it 'segments loooooooooooong names' do
    syllables = Rng::SyllableSegmenter.segment('Mephistopheles')
    syllables.should_not be_nil
    syllables.should be_an(Array)
    syllables.size.should == 5
  end
  
  it 'segments names into non-overlapping, non-empty syllables' do
    name = 'Andromeda'
    syllables = Rng::SyllableSegmenter.segment(name)
    syllables.should_not be_nil
    syllables.should be_an(Array)
    syllables.join('').should == name.downcase
  end
end