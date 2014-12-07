require_relative File.join('..', 'spec_helper')

describe Rng::NameFileLoader do
  context '.load' do
    let(:path) { File.join('spec', 'data', 'names.csv') }

    it 'loads a csv file with names' do
      # Load the file
      names = subject.load(path)

      expect(names).to_not be_nil
      expect(names.size).to be > 0
    end

    it 'raises when path is invalid' do
      expect { subject.load('foobar.csv') }.to raise_error(Rng::FileLoadError)
    end
  end
end