require_relative File.join('..', 'spec_helper')

describe Rng::GeneratedName do
  let(:sources) { ['Thorin', 'Limdor'] }
  let(:segmenter) { Rng::Segmenters::FantasyNameSegmenter }
  let(:name) { Rng::GeneratedName.new('Thodor', sources, segmenter) }
  let(:source_names) { name.source_names }

  it 'provides an array of source names used to derive this name' do
    expect(source_names).to_not be_nil
    expect(source_names.size).to eq(2)
  end
end