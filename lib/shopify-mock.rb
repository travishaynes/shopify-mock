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

      # Paths that contain the fixtures for the mocked requests and responses.
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
      def setup(mock=nil)
        if mock.nil?
          ActiveResource::HttpMock.respond_to {|mock| setup(mock) }
        else
          fixtures_for(:responses).each {|*args| mock_response(mock, *args) }
        end
      end

      def mock_response(mock, verb, endpoint, fixture)
        mock.public_send(
          verb,
          endpoint,
          request_headers_for(verb, endpoint),
          fixture.json(erb_context),
          fixture.yaml.fetch('status', 200),
          fixture.yaml.fetch('headers', {})
        )
      end

      def request_headers_for(verb, endpoint)
        headers = ShopifyAPI::Base.headers.dup
        headers['X-Shopify-Access-Token'] = ShopifyAPI::Mock.token
        request = fixtures_for(:requests)[verb][endpoint]
        return headers if request.nil?
        headers.merge(request.yaml.fetch('headers', {}))
      end

      # Loads the fixtures for the supplied type.
      #
      # @param [Symbol] type Can be either :responses or :requests.
      # @return [Array] An array of ShopifyAPI::Mock::Fixtures.
      def fixtures_for(type)
        @fixtures ||= {}

        @fixtures[type] ||= begin
          paths = fixture_paths.map {|path| File.join(path, "#{type}") }
          ShopifyAPI::Mock::Fixtures.new(*paths)
        end
      end

      # Removes the mocked requests.
      #
      # @see ShopifyAPI::Mock.setup
      def teardown
        ActiveResource::HttpMock.reset!

        @token = nil
        @erb_context = nil
        @fixtures = {}
      end
    end
  end
end
