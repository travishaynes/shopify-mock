articles = ShopifyAPI::Mock::Fixtures.read(:articles)
count    = ShopifyAPI::Mock::Fixtures.read(:count)

ShopifyAPI::Mock::Response.register(:get, "articles/count.json", count)
ShopifyAPI::Mock::Response.register(:get, "articles.json", articles)
