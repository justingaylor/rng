require_relative File.join('..', '..', 'spec_helper')

describe Rng::Segmenters::JapaneseNameSegmenter do

  context '.segment' do

    context 'segmenting single syllable names' do
      ['Go', 'Ya', 'Fu'].each do |name|
        it "segments '#{name}'" do
          syllables = subject.segment(name)
          expect(syllables).to_not be_nil
          expect(syllables).to be_an(Array)
          expect(syllables.size).to eq(1)
        end
      end
    end

    context 'segmenting double syllable names' do
      ['Boze', 'Kazu', 'Fumi', 'Bun', 'Saji'].each do |name|
        it "segments '#{name}'" do
          syllables = subject.segment(name)
          expect(syllables).to_not be_nil
          expect(syllables).to be_an(Array)
          expect(syllables.size).to eq(2)
        end
      end
    end

    context 'segmenting triple syllable names' do
      ['Asano', 'Kaiga', 'Hoizu', 'Mikami', 'Fudajo'].each do |name|
        it "segments '#{name}'" do
          syllables = subject.segment(name)
          expect(syllables).to_not be_nil
          expect(syllables).to be_an(Array)
          expect(syllables.size).to eq(3)
        end
      end
    end

    context 'segmenting quadruple syllable names' do
      ['Nobunaga', 'Ieyasu', 'Masamune', 'Bungoro', 'Ujiie', 'Hattori', 'Echizen'].each do |name|
        it "segments '#{name}'" do
          syllables = subject.segment(name)
          expect(syllables).to_not be_nil
          expect(syllables).to be_an(Array)
          expect(syllables.size).to eq(4)
        end
      end
    end

    context 'for looooooooooooong names' do
      ['Chousokabe', 'Shikanosuke', 'Kirigakure', 'Honganji'].each do |name|
        it "segments '#{name}'" do
          syllables = subject.segment(name)
          expect(syllables).to_not be_nil
          expect(syllables).to be_an(Array)
          expect(syllables.size).to be > 4
        end
      end
    end

    ['Hanzou', 'Kotarou', 'Fuuma'].each do |name|
      it "segments '#{name}' into non-overlapping, non-empty syllables" do
        syllables = subject.segment(name)
        expect(syllables).to_not be_nil
        expect(syllables).to be_an(Array)
        expect(syllables.join('')).to eq(name.downcase)
      end
    end


  end
end