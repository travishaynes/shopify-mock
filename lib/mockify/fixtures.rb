module ShopifyAPI
  module Mock
    class Fixtures
      @cache = {}
      
      class << self
        
        def read(name, ext = :json)
          fixture_name = "#{name.to_s}.#{ext.to_s}"
          fixture = File.expand_path("../fixtures/#{fixture_name}", __FILE__)
          raise "invalid fixture name" unless File.exists? fixture
          @cache[fixture_name] = File.read(fixture) unless @cache.include? fixture_name
          @cache[fixture_name]
        end
      
        def use(name, content)
          @cache["#{name}.json"] = content
        end
        
      end
    end
  end
end
