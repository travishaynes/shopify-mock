module ShopifyAPI
  module Mock
    class Fixtures
      @cache = {}
      
      class << self
        
        def read(name, ext = :json)
          fixture_name = "#{name.to_s}.#{ext.to_s}"
          fixture = File.join(self.path, fixture_name)
          raise "invalid fixture name" unless File.exists? fixture
          @cache[fixture_name] = File.read(fixture) unless @cache.include? fixture_name
          @cache[fixture_name]
        end
        
        def use(name, content)
          name = "#{name}.json"
          if content == :default
            @cache.delete name if @cache.include? name
          else
            @cache[name] = content
          end
        end
        
        def path
          @path ||= File.expand_path("../fixtures/", __FILE__)
        end
        
        def path=(value)
          @path = value
        end
        
        def reset
          @cache = {}
          @path = nil
        end
        
      end
    end
  end
end
