module Mockify
  class Fixtures
    def self.read(name, ext = :json)
      fixture = File.expand_path("../fixtures/#{name.to_s}.#{ext.to_s}", __FILE__)
      raise "invalid fixture name" unless File.exists? fixture
      File.read(fixture)
    end
  end
end
