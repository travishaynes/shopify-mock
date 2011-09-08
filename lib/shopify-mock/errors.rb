module ShopifyAPI
  module Mock
    # raised on the event that access is attempted while Shopify::Mock is disabled
    class DisabledError < StandardError; end
  end
end
