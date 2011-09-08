require 'fakeweb'

require 'shopify-mock/errors'
require 'shopify-mock/urls'
require 'shopify-mock/fixtures'
require 'shopify-mock/response'

# Mock is an extension for the ShopifyAPI
module ShopifyAPI
  # the main module for managing the Shopify mocks
  module Mock
    class << self
      # get the enabled state of ShopifyAPI::Mock
      # @return [Boolean] true if enabled
      # @example Check if ShopifyAPI::Mock is enabled
      #   ShopifyAPI::Mock.enabled # => true or false
      # @api public
      def enabled?
        @enabled || false
      end
      
      # enable or disable ShopifyAPI::Mock
      # @param [Boolean] value true to enable ShopifyAPI::Mock, false to disable
      # @return [Boolean] true if enabled
      # @example Enabling ShopifyAPI::Mock
      #   ShopifyAPI::Mock.enabled = true
      # @api public
      def enabled=(value=false)
        return @enabled if value == @enabled
        if value
          #load File.expand_path("../shopify-mock/responses.rb", __FILE__)
          ShopifyAPI::Mock.register_fixed_responses
        else
          ShopifyAPI::Mock::Response.clear
        end
        @enabled = value
      end
      
      # resets the ShopifyAPI::Mocks back to their original state
      # @return [Boolean] true when successful
      # @example Reset the mocks
      #   ShopifyAPI::Mock.reset
      # @raise [ShopifyAPI::Mock::DisabledError] Raised when trying to reset the mocks when they are disabled
      # @api public
      def reset
        raise ShopifyAPI::Mock::DisabledError, "cannot reset ShopifyAPI::Mock while it is disabled" \
          unless ShopifyAPI::Mock.enabled?
        ShopifyAPI::Mock.enabled = false
        ShopifyAPI::Mock.enabled = true
      end
      
      # gets the state of access to the real Internet
      # @return [Boolean] false if all access to the Internet has been disabled
      # @example Check if access has been disabled
      #   can_access_internet = Shopify::Mock.allow_internet
      # @api public
      def allow_internet?
        @allow_internet || true
      end
      
      # enables or disables access to the real Internet
      # @return [Boolean] status of real Internet access
      # @example Turn off access to the Internet altogether
      #   Shopify::Mock.allow_internet = false
      # @api public
      def allow_internet=(state = true)
        return @allow_internet if @allow_internet == state
        @allow_internet = state
        FakeWeb.allow_net_connect = @allow_internet
      end
      
      # registers all the fixed responses
      # @return [Array] the responses that were registered
      # @api private
      def register_fixed_responses
        ShopifyAPI::Mock::Response.clear
        
        registered_responses = []
        ShopifyAPI::Mock::Fixture.all.each do |fixture|
          # register the count fixture for this resource
          count_fixture = ShopifyAPI::Mock::Fixture.find(:count, fixture.ext.to_sym)
          registered_responses << ShopifyAPI::Mock::Response.new(
            :get, "#{fixture.name.to_s}/count.#{fixture.ext}",
            count_fixture.data
          )
          # register the resource fixture
          registered_responses << ShopifyAPI::Mock::Response.new(
            :get, "#{fixture.name.to_s}.#{fixture.ext.to_s}",
            fixture.data
          )
        end
        registered_responses
      end
    end
  end
end

# enable mocking in Rails test environments by default
ShopifyAPI::Mock.enabled = defined?(Rails) && Rails.env.test?
