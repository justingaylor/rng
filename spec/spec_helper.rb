require_relative File.join('..', 'lib', 'rng.rb')

require 'rspec'
require 'pry'

RSpec.configure do |config|
  config.mock_framework = :rspec

  config.before(:suite) do
    # Right now, we do nothing
  end
end