require 'rng/generated_name'


describe Rng::GeneratedName do
  before(:each) do
    @sources = ['Thorin', 'Limdor']
    @name = Rng::GeneratedName.new('Thodor', @sources)
  end
  
  it 'provides an array of source names used to derive this name' do
    @name.source_names.should_not be_nil
    @name.source_names.size.should == 2
  end
end