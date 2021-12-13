RSpec.configure do |config|
  config.use_transactional_fixtures = false

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:suite) { DatabaseCleaner.strategy = :truncation }

  config.before { DatabaseCleaner.start }

  config.after { DatabaseCleaner.clean }

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
