# frozen_string_literal: true

require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
  add_filter '/vendor/'
  minimum_coverage 95
end

# Load all files from lib directory
Dir[File.join(__dir__, '..', 'lib', '**', '*.rb')].each { |f| require f }

RSpec.configure do |config|
  # Use the expect syntax
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
    expectations.syntax = :expect
  end

  # The `should` syntax is disabled
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
    mocks.syntax = :expect
  end

  # Run specs in random order
  config.order = :random
  Kernel.srand config.seed

  # Filter lines from Rails gems in backtraces
  config.filter_run_when_matching :focus

  # Print the 10 slowest examples
  config.profile_examples = 10 if ENV['PROFILE']

  # Disable monkey patching
  config.disable_monkey_patching!

  # Warnings enabled
  config.warnings = true if ENV['WARNINGS']
end
