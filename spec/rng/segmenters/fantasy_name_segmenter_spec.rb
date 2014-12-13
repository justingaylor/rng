require_relative File.join('..', '..', 'spec_helper')

describe Rng::Segmenters::FantasyNameSegmenter do

  context '.segment' do

    context 'segmenting single syllable names' do
      ['Thor', 'Lir', 'Drizzt', 'Haask', ].each do |name|
        it "segments '#{name}'" do
          syllables = subject.segment(name)
          expect(syllables).to_not be_nil
          expect(syllables).to be_an(Array)
          expect(syllables.size).to be(1)
        end
      end
    end

    context 'segmenting double syllable names' do
      ['Thorin', 'Halphas', 'Iblis', 'Heimdall'].each do |name|
        it "segments '#{name}'" do
          syllables = subject.segment(name)
          expect(syllables).to_not be_nil
          expect(syllables).to be_an(Array)
          expect(syllables.size).to be(2)
        end
      end
    end

    context 'segmenting triple syllable names' do
      ['Mephisto', 'Haborym', 'Gwyllion', 'Drekavac'].each do |name|
        it "segments '#{name}'" do
          syllables = subject.segment(name)
          expect(syllables).to_not be_nil
          expect(syllables).to be_an(Array)
          expect(syllables.size).to be(3)
        end
      end
    end

    it 'segments loooooooooooong names' do
      syllables = subject.segment('Mephistopheles')
      expect(syllables).to_not be_nil
      expect(syllables).to be_an(Array)
      expect(syllables.size).to be(5)
    end

    it 'segments names into non-overlapping, non-empty syllables' do
      name = 'Andromeda'
      syllables = subject.segment(name)
      expect(syllables).to_not be_nil
      expect(syllables).to be_an(Array)
      expect(syllables.join('')).to eq(name.downcase)
    end

    let(:path) { File.expand_path(File.join('data', 'names.csv')) }
    let(:loader) { Rng::NameFileLoader.new }

    it 'segments all names in names.csv' do
      names = loader.load(path)
    end

  end
end