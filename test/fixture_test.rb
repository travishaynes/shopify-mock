require 'test_helper'

class FixtureTest < ActiveSupport::TestCase
  setup do
    path = File.expand_path('../fixtures/main/test.json', __FILE__)
    @fixture = ShopifyAPI::Mock::Fixture.new(path)
  end

  test 'yaml is correctly extracted and parsed from header of JSON fixture' do
    assert @fixture.yaml.is_a?(Hash)
    assert @fixture.has_yaml?
    assert_equal 'application/json', @fixture.yaml['headers']['Content-Type']
    assert_equal 200, @fixture.yaml['status']
  end

  test 'raw JSON is extracted from the file without the YAML header' do
    assert_equal '{ "Hello": "<%= world %>" }', @fixture.raw_json.strip
  end

  test 'JSON is correctly read and parsed from ERB' do
    world = 'WORLD'

    assert_equal '{ "Hello": "WORLD" }', @fixture.json(binding).strip
  end
end
