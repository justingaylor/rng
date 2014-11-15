require_relative File.join('..', 'spec_helper')

describe Rng::Syllable do
  let(:syllable) { Rng::Syllable.new("TH", "O", "R") }

  it 'can be converted to a down-cased string' do
    expect(syllable).to respond_to(:to_s)
    expect(syllable.to_s).to eq('thor')
  end

  it 'provides an initial field' do
    expect(syllable.initial).to eq('th')
  end

  it 'provides an inner field' do
    expect(syllable.inner).to eq('o')
  end

  it 'provides a final field' do
    expect(syllable.final).to eq('r')
  end

  it 'supports an empty final sound' do
    syl = Rng::Syllable.new('FL', 'O')
    expect(syl.to_s).to eq('flo')
  end

end