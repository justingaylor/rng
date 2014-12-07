require_relative File.join('..', 'spec_helper')

describe Rng::Generator do
  let(:path) { File.expand_path(File.join('spec', 'data', 'names.csv')) }
  let(:generator) { Rng::Generator.new(path) }

  it 'generates a specified number of names' do
    names = generator.generate(10)
    expect(names).to_not be_nil
    expect(names.size).to eq(10)
  end

  it 'generates names less than or equal to a specified length' do
    names = generator.generate(10, 6)
    expect(names).to_not be_nil
    names.each do |name|
      expect(name.length).to be < 10
    end
  end

  # Very simple => exactly two syllable names (an initial and final only)
  it 'generates names using the "very_simple" algorithm' do
    names = generator.generate(10, 8, :very_simple)
    expect(names).to_not be_nil
    names.each do |name|
      expect(name).to be_an(Rng::GeneratedName)
      expect(name.length).to be < 10
    end
  end

  # Simple => Initial and final syllables + 0 or more intermediates
  it 'generates names using the "simple" algorithm' do
    names = generator.generate(10, 20, :simple)
    expect(names).to_not be_nil
    expect(names.size).to eq(10)
    names.each do |name|
      expect(name).to be_an(Rng::GeneratedName)
      expect(name.length).to be <= 20
    end
  end

end