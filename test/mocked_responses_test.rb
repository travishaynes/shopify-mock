require 'test_helper'

class MockedResponsesTest < ActiveSupport::TestCase
  setup do
    ShopifyAPI::Mock.setup
  end

  teardown do
    ShopifyAPI::Mock.teardown
  end

  test 'requests without responses' do
    session do
      assert_raises ActiveResource::InvalidRequestError do
        ShopifyAPI::Order.find('x')
      end
    end
  end

  test 'requests to a mocked response' do
    session do
      assert_kind_of ShopifyAPI::Order, ShopifyAPI::Order.first
      assert_kind_of ShopifyAPI::Event, ShopifyAPI::Event.find(677313116)
      assert_kind_of ShopifyAPI::Shop, ShopifyAPI::Shop.current
    end
  end

  private

  def session(&block)
    ShopifyAPI::Session.temp('test.myshopify.com', ShopifyAPI::Mock.token) do
      yield if block_given?
    end
  end
end
