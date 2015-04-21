module ShopifyAPI
  module Mock
    # Provides a collection of fixtures grouped by their HTTP verbs.
    #
    # The expected directory structure for the fixture paths is as follows:
    #
    #     /root/path/:http_verb/file.json?query
    #
    # The root path is what will be supplied. The query is optional. Regarding
    # file names, all that matters is that the file has a '.json' extension for
    # it to be recognized as a fixture.
    #
    # @example Retrieving a fixture.
    #
    #     path = File.expand_path('../fixtures/responses', __FILE__)
    #     fixtures = ShopifyAPI::Mock::Fixtures.new(path)
    #     fixtures[:get]['/events.json']
    #
    class Fixtures
      include Enumerable

      # The paths this collection of fixtures reads from.
      #
      # @return [Array] The full fixtures-root pathnames.
      attr_reader :paths

      # Constructs a Fixtures from the supplied path.
      #
      # @param [String] paths The full paths that contain the fixtures.
      # @return [ShopifyAPI::Mock::Fixtures] The fixtures collection.
      def initialize(*paths)
        @paths = paths

        reload
      end

      # Gets the fixtures for the supplied verb.
      #
      # @param [Symbol] verb The HTTP verb.
      # @return [Hash] Contains the fixtures with the endpoints as the keys.
      def [](verb)
        @fixtures.fetch(verb, {})
      end

      # Calls the given block once for each fixture, passing the verb, endpoint,
      # and fixture as parameters.
      #
      # An `Enumerator` is returned if no block is given.
      #
      # @example Printing all the fixtures' HTTP verb, endpoint and JSON values.
      #
      #     fixtures.each do |verb, endpoint, fixture|
      #       puts "#{verb.upcase} #{endpoint}"
      #       puts fixture.json
      #     end
      #
      def each(&block)
        return enum_for(:each) unless block_given?

        @fixtures.each do |verb, fixtures|
          fixtures.each do |endpoint, fixture|
            block.call(verb, endpoint, fixture)
          end
        end
      end

      # Reloads the fixtures.
      def reload
        @fixtures = {}
        paths.each {|path| load_fixtures(path) }
      end

      private

      # Loads the fixtures in the supplied path.
      #
      # @param [String] path The root path that contains the fixtures.
      def load_fixtures(path)
        subdirs(path).each do |subdir|
          verb = verb_from_path(path, subdir)
          @fixtures[verb] = map_fixtures(path, subdir, verb)
        end
      end

      # Maps the fixtures for the path to the supplied verb.
      #
      # @param [String] root The root path for the fixtures.
      # @param [String] path The subdir to read the fixtures from.
      # @param [Symbol] verb The HTTP verb the fixtures are for.
      # @return [Hash] The fixtures.
      def map_fixtures(root, path, verb)
        @fixtures[verb] = fixture_files(path).inject({}) do |result, file|
          result.merge!(get_endpoint(root, file, verb) => Fixture.new(file))
        end
      end

      # Extracts the URL endpoint from the supplied file name.
      #
      # @param [String] file The filename.
      # @param [Symbol] verb The HTTP verb of the fixture.
      # @return [String] The URL endpoint.
      def get_endpoint(path, file, verb)
        file.gsub(/^#{path}\/#{verb.to_s}/, '')
      end

      # Recursively gets the file names of the fixtures in the supplied path.
      #
      # @param [String] path The path to search for fixtures in.
      # @return [Array] The names of all the fixtures in the path.
      def fixture_files(path)
        Dir[File.join(path, '**', '*.json*')].reject do |file|
          !File.file?(file)
        end
      end

      # Extracts the HTTP verb from the supplied path.
      #
      # @param [String] root The root path containing the fixtures.
      # @param [String] subdir A sub-directory of the root path - full pathname.
      # @return [Symbol] The HTTP verb for the fixtures in the path.
      def verb_from_path(root, subdir)
        subdir
          .gsub(/^#{root}/, '')
          .split(File::SEPARATOR)
          .reject {|part| part.strip == '' }
          .first.to_sym
      end

      # Collects one level of sub directories for the supplied path.
      #
      # @param [String] path The path to search.
      # @return [Array] The sub-directories directly in the path.
      def subdirs(path)
        Dir[File.join(path, '*')].reject {|file| !File.directory?(file) }
      end
    end
  end
end
