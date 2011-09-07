require 'spec_helper'

describe ShopifyAPI::Mock::Fixtures do
  
  describe "#all" do
    it "should return an array" do
      ShopifyAPI::Mock::Fixtures.all.should be_kind_of Array
    end
  end
  
  context "when given a valid fixture name" do
    it "should return the contents of a fixture" do
      @json = read_fixture :test
      @xml = read_fixture :test, :xml
      ShopifyAPI::Mock::Fixtures.read(:test).should eq @json
      ShopifyAPI::Mock::Fixtures.read(:test, :xml).should eq @xml
    end
  end
  
  context "when given an invalid fixture name" do
    it "should raise an error" do
      expect { ShopifyAPI::Mock::Fixtures.read(:brown_chicken_brown_cow) }.should raise_error
    end
  end
  
  context "custom fixtures json" do
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
        it "should reset back to default fixture" do
          ShopifyAPI::Mock::Fixtures.use :count, @json
          ShopifyAPI::Mock::Fixtures.read(:count).should eq @json
          ShopifyAPI::Mock::Fixtures.use :count, :default
          ShopifyAPI::Mock::Fixtures.read(:orders).should eq read_fixture :orders
        end
      end
    end
  end
  
  context "custom fixtures xml" do
    before { @xml = '<?xml version="1.0" encoding="UTF-8"?><count type="integer">10</count>' }
    describe "#use" do
      context "with custom fixture for content" do
        it "should override default fixture" do
          ShopifyAPI::Mock::Fixtures.read(:orders, :xml).should eq read_fixture :orders, :xml
          ShopifyAPI::Mock::Fixtures.read(:count, :xml).should eq read_fixture :count, :xml
          ShopifyAPI::Mock::Fixtures.use :count, @xml, :xml
          ShopifyAPI::Mock::Fixtures.read(:count, :xml).should eq @xml
        end
      end
      context "with :default for content" do
        it "should reset back to default fixture" do
          ShopifyAPI::Mock::Fixtures.use :count, @xml, :xml
          ShopifyAPI::Mock::Fixtures.read(:count, :xml).should eq @xml
          ShopifyAPI::Mock::Fixtures.use :count, :default, :xml
          ShopifyAPI::Mock::Fixtures.read(:count, :xml).should eq read_fixture :count, :xml
          ShopifyAPI::Mock::Fixtures.read(:orders, :xml).should eq read_fixture :orders, :xml
        end
      end
    end
  end
end
