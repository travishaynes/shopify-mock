$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'shopify-mock'
require 'minitest/autorun'
require 'byebug'

ActiveSupport::TestCase.test_order = :random
