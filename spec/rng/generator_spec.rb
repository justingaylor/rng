require 'rng/generator'


describe Rng::Generator do
  before(:each) do
    @path = File.join('spec', 'data', 'names.csv')
    @generator = Rng::Generator.new(@path)
  end
  
  it 'generates a specified number of names' do
    @names = @generator.generate(10)
    @names.should_not be_nil
    @names.size.should == 10
  end
  
  it 'generates names less or equal to a specified length' do
    @names = @generator.generate(10, 6)
    @names.should_not be_nil
    @names.each do |name|
      name.length.should be <= 6
    end
  end
  
  it 'generates names using a very simple algorithm' do
    # Very simple => exactly two syllable names (an initial and final only)
    @names = @generator.generate(10, 8, :very_simple)
    @names.should_not be_nil
    @names.each do |name|
      name.should be_an(Rng::GeneratedName)
      name.length.should be <= 10
    end
  end
  
  it 'generates names using a simple algorithm' do
    # Simple => Initial and final syllables + 0 or more intermediates
    @names = @generator.generate(10, 20, :simple)
    @names.should_not be_nil
    @names.size.should == 10
    @names.each do |name|
      name.should be_an(Rng::GeneratedName)
      name.length.should be <= 20
    end
  end
  
  it 'generates names using a bayesian algorithm'
end