require 'fakeweb'

require 'mockify/version'
require 'mockify/urls'
require 'mockify/fixtures'

module Mockify
  
  class << self
    def enabled
      @enabled || false
    end
    
    def enabled=(value=false)
      return @enabled if value == @enabled
      if value
        load File.expand_path("../mockify/responses.rb", __FILE__)
      else
        FakeWeb.clean_registry
      end
      @enabled = value
    end
    
    def allow_internet
      @allow_internet || true
    end
    
    def allow_internet=(state = true)
      return @allow_internet if @allow_internet == state
      @allow_internet = state
      FakeWeb.allow_net_connect = @allow_internet
    end
  end

end

Mockify.enable if defined?(Rails) && Rails.env.test?
