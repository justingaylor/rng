require 'rng/syllable'


describe Rng::Syllable do
  before(:each) do
    @syllable = Rng::Syllable.new("TH", "O", "R")
  end
  
  it "can be instantiated" do
    # Do nothing
  end
  
  it "can be converted to a down-cased string" do
    @syllable.should respond_to(:to_s)
    @syllable.to_s.should == "thor"
  end
  
  it "supports an empty final sound" do
    @syl = Rng::Syllable.new("FL", "O")
    @syl.to_s.should == "flo"
  end
  
  it "provides an initial field" do
    @syllable.initial.should == "th"
  end
  
  it "provides an inner field" do
    @syllable.inner.should == "o"
    
  end
  
  it "provides an final field" do
    @syllable.final.should == "r"
    
  end
  
end