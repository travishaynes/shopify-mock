module ShopifyAPI
  module Mock
    class Fixtures
      @cache = {}
      
      class << self
        
        def all(ext = :json)
          Dir[File.join(ShopifyAPI::Mock::Fixtures.path, "**", "*.#{ext.to_s}")].map do |fixture|
            File.basename(fixture, ".#{ext.to_s}").to_sym
          end
        end
        
        def read(name, ext = :json)
          fixture_name = "#{name.to_s}.#{ext.to_s}"
          fixture = File.join(self.path, fixture_name)
          raise "invalid fixture name" unless File.exists? fixture
          @cache[fixture_name] = File.read(fixture) unless @cache.include? fixture_name
          @cache[fixture_name]
        end
        
        def use(name, content, ext = :json)
          name = "#{name}.#{ext.to_s}"
          if content == :default
            @cache.delete name if @cache.include? name
          else
            @cache[name] = content
          end
          ShopifyAPI::Mock.reset
        end
        
        def path
          @path ||= File.expand_path("../fixtures/", __FILE__)
        end
        
        def path=(value)
          @path = value
          ShopifyAPI::Mock.reset
        end
        
        def reset
          @cache = {}
          @path = nil
          ShopifyAPI::Mock::Responses.register_all
        end
        
      end
    end
  end
end
