require 'spec_helper'

describe ShopifyAPI::Mock::Fixtures do
  
  context "when given a valid fixture name" do
    it "should return the contents of a fixture" do
      @json = read_fixture :test
      ShopifyAPI::Mock::Fixtures.read(:test).should eq @json
    end
  end
  
  context "when given an invalid fixture name" do
    it "should raise an error" do
      expect { ShopifyAPI::Mock::Fixtures.read(:brown_chicken_brown_cow) }.should raise_error
    end
  end
  
  context "custom fixtures" do
    before { @json = '{ "count": 10 }' }
    describe "#use" do
      context "with custom fixture for content" do
        it "should override default fixture" do
          ShopifyAPI::Mock::Fixtures.read(:orders).should eq read_fixture :orders
          ShopifyAPI::Mock::Fixtures.use :count, @json
          ShopifyAPI::Mock::Fixtures.read(:count).should eq @json
        end
      end
      context "with :default for content" do
        it "should reset back to default texture" do
          ShopifyAPI::Mock::Fixtures.use :count, @json
          ShopifyAPI::Mock::Fixtures.read(:count).should eq @json
          ShopifyAPI::Mock::Fixtures.use :count, :default
          ShopifyAPI::Mock::Fixtures.read(:orders).should eq read_fixture :orders
        end
      end
    end
  end
  
end
