require 'erb'
require 'yaml'
require 'securerandom'
require 'shopify_api'
require 'shopify-mock/version'
require 'shopify-mock/fixture'
require 'shopify-mock/fixtures'

module ShopifyAPI
  module Mock
    class << self
      # The JSON fixtures can contain ERB. Set this variable to to the context
      # to use when compiling the ERB.
      #
      # @return [Binding] The ERB context binding; can be nil and is by default.
      attr_accessor :erb_context

      # The token is reset to nil when #teardown is called.
      attr_writer :token

      # The Shopify API requires an access token, which belongs to a specific
      # shop. By default one will be randomly generated unless set manually.
      #
      # @return [String] The access token.
      def token
        @token ||= SecureRandom.hex(16)
      end

      # Paths that contain the fixtures for the mocked responses.
      #
      # @example Adding a custom path.
      #
      #     ShopifyAPI::Mock.fixture_paths << custom_path
      #
      # @example Removing the default fixtures and only using custom ones.
      #
      #     ShopifyAPI::Mock.fixture_paths.clear
      #     ShopifyAPI::Mock.fixture_paths << custom_path
      #
      # @return [Array] A list of paths to load fixtures from.
      def fixture_paths
        @fixture_paths ||= [File.expand_path('../../fixtures', __FILE__)]
      end

      # Sets up the mocks.
      #
      # @see ShopifyAPI::Mock.teardown
      #
      # @example Setting up the mocks on a test by test basis.
      #
      #     class SomeText < Minitest::Test
      #       def setup
      #         ShopifyAPI::Mock.setup
      #       end
      #
      #       def teardown
      #         ShopifyAPI::Mock.teardown
      #       end
      #     end
      #
      # @param [ActiveResource::HttpMock::Responder] An optional responder.
      # @return [NilClass]
      def setup(mock=nil)
        if mock.nil?
          ActiveResource::HttpMock.respond_to {|mock| setup(mock) }
        else
          fixtures.each {|*args| mock_response(mock, *args) }
        end

        nil
      end

      # Mocks a response for the API.
      #
      # @param [ActiveResource::HttpMock::Responder] The responder to use.
      # @param [Symbol] verb The HTTP verb.
      # @param [String] endpoint The request's API endpoint.
      # @param [ShopifyAPI::Mock::Fixture] The fixture to use for the mock.
      def mock_response(mock, verb, endpoint, fixture)
        mock.public_send(
          verb,
          endpoint,
          request_headers,
          fixture.json(erb_context),
          fixture.yaml.fetch('status', 200),
          fixture.yaml.fetch('headers', {})
        )
      end

      # Generates request headers for making a request to the API.
      #
      # @return [Hash] The request headers.
      def request_headers
        ShopifyAPI::Base.headers.dup.merge(
          'X-Shopify-Access-Token' => ShopifyAPI::Mock.token)
      end

      # Gets the fixtures.
      #
      # @return [ShopifyAPI::Mock::Fixtures] The fixtures.
      def fixtures
        @fixtures ||= ShopifyAPI::Mock::Fixtures.new(*fixture_paths)
      end

      # Removes the mocked responses.
      #
      # @see ShopifyAPI::Mock.setup
      def teardown
        ActiveResource::HttpMock.reset!

        @token = nil
        @erb_context = nil
        @fixtures = nil
      end
    end
  end
end
