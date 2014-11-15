require_relative File.join('..', 'spec_helper')

describe Rng::NameFileLoader do
  let(:path) { File.join('spec', 'data', 'names.csv') }
  let(:loader) { loader = Rng::NameFileLoader.new }

  it 'loads a csv file with names' do
    # Load the file
    names = loader.load(path)

    expect(names).to_not be_nil
    expect(names.size).to be > 0
  end
end