require 'fakeweb'

require 'shopify-mock/version'
require 'shopify-mock/urls'
require 'shopify-mock/fixtures'

module ShopifyAPI
  module Mock
    class << self
      def enabled
        @enabled || false
      end
      
      def enabled=(value=false)
        return @enabled if value == @enabled
        if value
          load File.expand_path("../shopify-mock/responses.rb", __FILE__)
        else
          FakeWeb.clean_registry
        end
        @enabled = value
      end
      
      def allow_internet
        @allow_internet || true
      end
      
      def allow_internet=(state = true)
        return @allow_internet if @allow_internet == state
        @allow_internet = state
        FakeWeb.allow_net_connect = @allow_internet
      end
    end
  end
end

ShopifyAPI::Mock.enable if defined?(Rails) && Rails.env.test?
