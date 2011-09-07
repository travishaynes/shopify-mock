module ShopifyAPI
  module Mock
    class Response
      class << self
        def register(method, resource, response)
          FakeWeb.register_uri(
            method, /#{SHOPIFY_MOCK_SHOP_BASE_URL}#{resource}/,
            :body => response
          )
        end
      end
    end
  end
end

require 'mockify/responses/orders'
require 'mockify/responses/articles'
