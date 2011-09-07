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
        
        def register_all
          count_fixture = ShopifyAPI::Mock::Fixtures.read(:count)
          ShopifyAPI::Mock::Fixtures.all.each do |fixture|
            ShopifyAPI::Mock::Response.register(:get, "#{fixture.to_s}/count.json", count_fixture)
            ShopifyAPI::Mock::Response.register(
              :get, "#{fixture.to_s}.json",
              ShopifyAPI::Mock::Fixtures.read(fixture)
            )
          end
          
          count_fixture = ShopifyAPI::Mock::Fixtures.read(:count, :xml)
          ShopifyAPI::Mock::Fixtures.all(:xml).each do |fixture|
            ShopifyAPI::Mock::Response.register(:get, "#{fixture.to_s}/count.xml", count_fixture)
            ShopifyAPI::Mock::Response.register(
              :get, "#{fixture.to_s}.xml",
              ShopifyAPI::Mock::Fixtures.read(fixture, :xml)
            )
          end
        end
        
      end
    end
  end
end
