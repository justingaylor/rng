require_relative File.join('..', '..', 'spec_helper')

class DummySegmenter
  include Rng::SyllableSegmenterBase

  $initials = ['th', 'r', 'n', 'm', 'g']
  $inners   = ['a', 'e', 'i', 'o', 'ie']
  $finals   = ['n', 'th', 'l', 'g', 'r', 'b', '']

  def self.initials; $initials; end
  def self.inners; $inners; end
  def self.finals; $finals; end
end

describe Rng::SyllableSegmenterBase do

  context '.init_longest_matching' do
    let(:syllables) { ["a", "abb", "ch"] }

    it 'sorts longest to shortest' do
      result = DummySegmenter.init_longest_matching(syllables)
      expect(result).to eq(["abb", "ch", "a"])
    end

    it 'actually modifies the original array' do
      DummySegmenter.init_longest_matching(syllables)
      expect(syllables).to_not eq(["a", "abb", "ch"])
    end
  end

  context '.init_shortest_matching' do
    let(:syllables) { ["a", "abb", "ch"] }

    it 'sorts shortest to longest' do
      result = DummySegmenter.init_shortest_matching(syllables)
      expect(result).to eq(["a", "ch", "abb"])
    end

    it 'actually modifies the original array' do
      DummySegmenter.init_shortest_matching(syllables)
      expect(syllables).to_not eq(["a", "abb", "ch"])
    end
  end

  context '.init_syllable_matching' do
    it 'initializes syllable orderings from longest to shortest' do
      orig_initials = DummySegmenter.initials.clone
      orig_inners   = DummySegmenter.inners.clone
      orig_finals   = DummySegmenter.finals.clone
      DummySegmenter.init_syllable_matching(
        DummySegmenter.initials,
        DummySegmenter.inners,
        DummySegmenter.finals
      )
      expect(DummySegmenter.initials).to_not eq(orig_initials)
      expect(DummySegmenter.inners).to_not eq(orig_inners)
      expect(DummySegmenter.finals).to_not eq(orig_finals)
    end
  end

  context '.extract_last_syllable' do
    before(:each) do
      DummySegmenter.init_syllable_matching(
        DummySegmenter.initials,
        DummySegmenter.inners,
        DummySegmenter.finals
      )
    end

    {
      'Thorin'     => Rng::Syllable.new('r', 'i', 'n'),
      'Abareth'    => Rng::Syllable.new('r', 'e', 'th'),
      'Gilthoniel' => Rng::Syllable.new('n', 'ie', 'l'),
      'Magena'     => Rng::Syllable.new('n', 'a', '')
    }.each do |name, last_syllable|
      it "extracts '#{last_syllable}' from the end of '#{name}'" do
        result = DummySegmenter.extract_last_syllable(name)
        expect(result.initial).to eq(last_syllable.initial)
        expect(result.inner).to eq(last_syllable.inner)
        expect(result.final).to eq(last_syllable.final)
      end
    end
  end

  context '.extract_first_syllable' do
    {
      'Thorin'     => Rng::Syllable.new('th', 'o', 'r'),
      'Abareth'    => Rng::Syllable.new('', 'a', 'b'),
      'Gilthoniel' => Rng::Syllable.new('g', 'i', 'l'),
      'Magena'     => Rng::Syllable.new('m', 'a', 'g')
    }.each do |name, first_syllable|
      it "extracts '#{first_syllable}' from the end of '#{name}'" do
        result = DummySegmenter.extract_first_syllable(name)
        expect(result.initial).to eq(first_syllable.initial)
        expect(result.inner).to eq(first_syllable.inner)
        expect(result.final).to eq(first_syllable.final)
      end
    end
  end
end