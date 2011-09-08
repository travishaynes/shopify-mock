require 'spec_helper'

describe ShopifyAPI::Mock::Fixture do
  
  describe "#new" do
    context "with invalid file name" do
      it "should raise IOError" do
        expect {ShopifyAPI::Mock::Fixture.new("invalid-file") }.should raise_error, IOError
      end
    end
    
    context "with valid file name" do
      before do
        @file_name = File.expand_path("../../lib/shopify-mock/fixtures/json/orders.json", __FILE__)
        @fixture = ShopifyAPI::Mock::Fixture.new(@file_name)
      end
      specify { @fixture.should be_a ShopifyAPI::Mock::Fixture }
    end
  end
  
  describe "#all" do
    before { @all = ShopifyAPI::Mock::Fixture.all }
    specify { @all.should be_kind_of Array }
    specify { @all.length.should > 0 }
  end
  
  describe "#find" do
    context "with a valid fixture name" do
      before { @result = ShopifyAPI::Mock::Fixture.find :orders, :json }
      specify { @result.should be_kind_of ShopifyAPI::Mock::Fixture }
    end
    context "with an invalid fixture name" do
      before { @result = ShopifyAPI::Mock::Fixture.find :brown_chicken_brown_cow, :xml }
      specify { @result.should be_nil }
    end
  end
  
  describe "#data" do
    before { @fixture = ShopifyAPI::Mock::Fixture.find :orders, :json }
    specify { @fixture.data.should_not be_empty }
  end
  
  describe "#data=" do
    before(:all) do
      @fixture = ShopifyAPI::Mock::Fixture.find :orders, :json
      @original_data = @fixture.data
    end
    it "should override the original content" do
      @fixture.data.should eq @original_data
      @fixture.data = 'new'
      @fixture.data.should eq 'new'
    end
    it "should reset to original content when set to nil" do
      @fixture.data = nil
      @fixture.data.should eq @original_data
    end
  end
  
end
