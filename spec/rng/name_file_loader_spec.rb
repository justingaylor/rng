require 'rng/name_file_loader'

describe Rng::NameFileLoader do
  before(:each) do
    @path = File.join('spec', 'data', 'names.csv')
  end
  
  it 'loads a csv file with names' do
    # Load the file
    @loader = Rng::NameFileLoader.new
    @names = @loader.load(@path)
    
    @names.should_not be_nil
    @names.size.should be > 0
  end
end