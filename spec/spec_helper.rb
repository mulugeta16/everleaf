RSpec.configure do |config|
  config.before(:each) do |example|
       if example.metadata[:type] == :system
         driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]  do |options|
           options.add_argument('no-sandbox')
         end
       end
     end
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
end
