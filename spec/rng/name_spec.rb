require_relative File.join('..', 'spec_helper')

describe Rng::Name do
  let(:thorin) { Rng::Name.new('Thorin') }
  let(:mephisto) { Rng::Name.new('Mephistopheles') }

  it 'provides a field for the name passed to it' do
    expect(thorin.name).to eq('Thorin')
  end

  it 'provides the raw version of name (with slashes separating syllables)' do
    expect(thorin.raw_name).to eq('Tho/rin')
  end

  it 'provides a to_s implementation which returns the name as a string' do
    expect(thorin.to_s).to eq(thorin.name)
  end

  it 'provides a length attribute' do
    expect(thorin.length).to eq(6)
  end

  it 'provides access to the syllables of the name' do
    expect(thorin.syllables).to_not be_nil
    expect(thorin.syllables).to be_an(Array)
    expect(thorin.syllables.size).to eq(2)
    thorin.syllables.each do |syllable|
      expect(syllable).to be_an(Rng::Syllable)
    end

    expect(mephisto.syllables).to_not be_nil
    expect(mephisto.syllables).to be_an(Array)
    expect(mephisto.syllables.size).to eq(5)
    mephisto.syllables.each do |syllable|
      expect(syllable).to be_an(Rng::Syllable)
    end
  end
end