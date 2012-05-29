require 'rng/name'

describe Rng::Name do
  before(:each) do
    @thorin = Rng::Name.new('Thorin')
    @mephistopheles = Rng::Name.new('Mephistopheles')
  end
  
  it 'provides a field for the name passed to it' do
    @thorin.name.should == 'Thorin'
  end
  
  it 'provides the raw version of name (with slashes separating syllables)' do
    @thorin.raw_name.should == 'Tho/rin'
  end
  
  it 'provides access to the syllables of the name' do
    @thorin.syllables.should_not be_nil
    @thorin.syllables.should be_an(Array)
    @thorin.syllables.size.should == 2
    @thorin.syllables.each do |syllable|
      syllable.should be_an(Rng::Syllable)
    end
    @mephistopheles.syllables.should_not be_nil
    @mephistopheles.syllables.should be_an(Array)
    @mephistopheles.syllables.size.should == 5
    @mephistopheles.syllables.each do |syllable|
      syllable.should be_an(Rng::Syllable)
    end
  end
end