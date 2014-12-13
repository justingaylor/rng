require 'rspec'
require 'rspec/its'
require 'pry'

require_relative File.join('..', 'lib', 'rng.rb')


RSpec.configure do |config|
  config.mock_framework = :rspec

  config.before(:suite) do
    # Right now, we do nothing
  end
end