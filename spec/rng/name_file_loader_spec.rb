require_relative File.join('..', 'spec_helper')

describe Rng::NameFileLoader do
  context '.load' do

    {
      Rng::Segmenters::FantasyNameSegmenter => File.join('spec', 'data', 'names.csv'),
      Rng::Segmenters::JapaneseNameSegmenter => File.join('data', 'sengoku-names.csv')
    }.each do |segmenter, path|
      it "loads '#{path}' successfully" do
        # Load the file
        names = Rng::NameFileLoader.new(segmenter).load(path)

        expect(names).to_not be_nil
        expect(names.size).to be > 0
      end
    end

    it 'raises when path is invalid' do
      expect { subject.load('foobar.csv') }.to raise_error(Rng::FileLoadError)
    end
  end
end