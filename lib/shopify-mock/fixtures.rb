module ShopifyAPI
  module Mock
    
    # provides easy access to fixtures
    class Fixture
      @path = nil
      @cache = {}
      
      # creates a new instance of ShopifyAPI::Mock::Fixture
      # @param [String] file_name The location of the file to load into the fixture
      # @raise [IOError] Raised when file_name is invalid
      # @api private
      def initialize(file_name)
        raise IOError, "File not found: #{file_name}" unless File.exists? file_name
        @file_name = file_name
      end
      
      # gets the content of the fixture
      # @return [String] the contents of the file, or @data if it was overwritten
      # @example Create a fixture and read its contents
      #   fixture = ShopifyAPI::Fixture("./orders.xml")
      #   data = fixture.data # => the contents of "./orders.xml"
      # @api public
      def data
        @data || File.read(@file_name)
      end
      
      # gets the name of the fixture
      # @return [Symbol] the the file name without the extension
      # @example Load a fixture and get its name
      #   fixture = ShopifyAPI::Fixture("./orders.xml")
      #   name = fixture.name # => :orders
      # @api public
      def name
        File.basename(@file_name, ".#{self.ext.to_s}").to_sym
      end
      
      # overrides the contents of the fixture
      # @param [String] value The new value to use, or set to nil to reset to default
      # @return The new contents of the fixture
      # @example Override a the contents of a fixture
      #   fixture = ShopifyAPI::Fixture("./orders.xml")
      #   data = fixture.data # => the contents of "./orders.xml"
      #   fixture.data = "hello world"
      #   data = fixture.data # => "hello world"
      # @api public
      def data=(value)
        @data = value
        data
      end
      
      # gets the extension of the fixture
      # @return [Symbol] The extension
      # @example Create a new fixture and get its extension
      #   fixture = ShopifyAPI::Fixture("./orders.xml")
      #   ext = fixture.ext # => :xml
      # @api public
      def ext
        File.extname(@file_name).gsub(".","").to_sym
      end
      
      class << self
        # finds all the fixtures
        # @return [Array, Fixture] an array of all the Fixtures
        # @example Find all the fixtures
        #   ShopifyAPI::Mock::Fixture.all
        # @api public
        def all
          Dir[File.join(ShopifyAPI::Mock::Fixture.path, "*")].map do |file_name|
            fixture_name = File.basename(file_name)
            @cache[fixture_name] ||= Fixture.new(file_name)
          end
        end
        
        # finds a fixture by name
        # @param [Symbol] name The name of the fixture
        # @param [Symbol] ext The extension of the symbol - defaults to :json
        # @return [ShopifyAPI::Mock::Fixture] The fixture or nil if not found
        # @example Find the orders json fixture
        #   fixture = ShopifyAPI::Mock::Fixture.find :orders
        # @example Find the orders xml fixture
        #   fixture = ShopifyAPI::Mock::Fixture.find :orders, :xml
        # @api public
        def find(name, ext = :json)
          fixture_name = "#{name.to_s}.#{ext.to_s}"
          file_name = File.join(self.path, fixture_name)
          return nil unless File.exists? file_name
          @cache[fixture_name] ||= Fixture.new(file_name)
        end
        
        # gets the current path to the fixtures
        # @return [String] The fixtures path
        # @example Get the fixtures path
        #   fixture_path = ShopifyAPI::Mock::Fixture.path
        # @api public
        def path
          @path ||= File.expand_path("../fixtures/", __FILE__)
        end
        
        # sets the current fixtures path
        # @param [String] value The new fixtures path
        # @return [String] The new fixtures path
        # @example Override the default fixtures path
        #   ShopifyAPI::Mock::Fixture.path = File.join(Rails.root, "spec", "fixtures", "shopify")
        # @api public
        def path=(value)
          return @path if @path == value
          @path = value
          @cache = {}
        end
      end
      
    end
  end
end
