# register response to read all orders
FakeWeb.register_uri(
  :get, /#{SHOPIFY_MOCK_SHOP_BASE_URL}orders.json/,
  :body => ShopifyAPI::Mock::Fixtures.read(:orders)
)

# register response to orders count
FakeWeb.register_uri(
  :get, /#{SHOPIFY_MOCK_SHOP_BASE_URL}orders\/count.json/,
  :body => ShopifyAPI::Mock::Fixtures.read(:count)
)
