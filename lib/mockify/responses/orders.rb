# register response to read all orders
FakeWeb.register_uri(
  :get, /#{MOCKIFY_SHOP_BASE_URL}orders.json/,
  :body => Mockify::Fixtures.read(:orders)
)

# register response to orders count
FakeWeb.register_uri(
  :get, /#{MOCKIFY_SHOP_BASE_URL}orders\/count.json/,
  :body => Mockify::Fixtures.read(:count)
)
