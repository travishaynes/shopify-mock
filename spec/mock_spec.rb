require 'spec_helper'

describe ShopifyAPI::Mock do
  
  describe "#enabled=" do
    context "given true" do
      before { ShopifyAPI::Mock.enabled = true }
      it "should register a response for each fixtures * 2 for the count fixtures" do        
        ShopifyAPI::Mock::Response.all.count.should eq ShopifyAPI::Mock::Fixture.all.count * 2
      end
    end
    
    context "given false" do
      before { ShopifyAPI::Mock.enabled = false }
      it "should clear all registered responses" do
        ShopifyAPI::Mock::Response.all.should be_empty
      end
    end
  end

  describe "#reset" do
    context "while ShopifyAPI::Mock is disabled" do
      it "should raise DisabledError" do
        ShopifyAPI::Mock.enabled = false
        expect { ShopifyAPI::Mock.reset }.to raise_error ShopifyAPI::Mock::DisabledError
      end
    end
    
    context "while ShopifyAPI::Mock is enabled" do
    end
  end
  
  describe "#allow_internet=" do
    context "given true" do
      before { ShopifyAPI::Mock.allow_internet = true }
      it "should allow Internet access" do
        FakeWeb.allow_net_connect?.should eq true
      end
    end
    
    context "given false" do
      before { ShopifyAPI::Mock.allow_internet = false }
      it "should not allow Internet access" do
        FakeWeb.allow_net_connect?.should eq false
      end
    end
  end
  
end
