require_relative File.join('..', 'spec_helper')

describe Rng::Syllable do
  subject { Rng::Syllable.new("TH", "O", "R") }

  its(:to_s) { should eq('thor') }
  its(:initial) { should eq('th') }
  its(:inner) { should eq('o') }
  its(:final) { should eq('r') }

  it 'defaults final sound to empty string' do
    syl = Rng::Syllable.new('FL', 'O')
    expect(syl.to_s).to eq('flo')
  end

end