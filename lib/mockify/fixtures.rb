module ShopifyAPI
  module Mock
    class Fixtures
      @cache = {}
      @path = File.expand_path("../fixtures/", __FILE__)
      
      class << self
        
        def read(name, ext = :json)
          fixture_name = "#{name.to_s}.#{ext.to_s}"
          fixture = File.join(@path, fixture_name)
          raise "invalid fixture name" unless File.exists? fixture
          @cache[fixture_name] = File.read(fixture) unless @cache.include? fixture_name
          @cache[fixture_name]
        end
      
        def use(name, content)
          @cache["#{name}.json"] = content
        end
        
        def path
          @path
        end
        
        def path=(value)
          @path = value
        end
        
      end
    end
  end
end
