require 'test_helper'

class FixturePathsTest < ActiveSupport::TestCase
  test 'fixtures_path exists and includes the default directory' do
    assert ShopifyAPI::Mock.respond_to?(:fixture_paths)

    path = File.expand_path('../../fixtures', __FILE__)
    assert ShopifyAPI::Mock.fixture_paths.include?(path)
  end
end
