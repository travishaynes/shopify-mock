# require the ShopifyMock library
require File.expand_path("../../lib/shopify-mock", __FILE__)

require 'shopify_api'

# load support files
Dir[File.expand_path("../support/**/*.rb", __FILE__)].each {|f| load f}

# enable ShopifyMock and disable real-world Internet access
ShopifyAPI::Mock.enabled = true
ShopifyAPI::Mock.allow_internet = false
