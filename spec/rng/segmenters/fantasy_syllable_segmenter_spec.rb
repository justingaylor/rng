require_relative File.join('..', '..', 'spec_helper')

describe Rng::Segmenters::FantasySyllableSegmenter do
  it 'can segment single syllable names' do
    syllables = subject.segment('Thor')
    expect(syllables).to_not be_nil
    expect(syllables).to be_an(Array)
    expect(syllables.size).to be(1)
  end

  it 'segments double syllable names' do
    syllables = subject.segment('Thorin')
    expect(syllables).to_not be_nil
    expect(syllables).to be_an(Array)
    expect(syllables.size).to be(2)
  end

  it 'segments triple syllable names' do
    syllables = subject.segment('Mephisto')
    expect(syllables).to_not be_nil
    expect(syllables).to be_an(Array)
    expect(syllables.size).to be(3)
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
end