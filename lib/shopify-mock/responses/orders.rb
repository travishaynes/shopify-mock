orders = ShopifyAPI::Mock::Fixtures.read(:orders)
count  = ShopifyAPI::Mock::Fixtures.read(:count)

ShopifyAPI::Mock::Response.register(:get, "orders/count.json", count)
ShopifyAPI::Mock::Response.register(:get, "orders.json", orders)

