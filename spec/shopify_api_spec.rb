require 'spec_helper'

shared_examples "a collection" do
  let(:collection) { described_class.all }
  
  describe "#all" do
    it "should be an Array of #{described_class}" do
      collection.should be_a Array
      collection.first.should be_a described_class
    end
  end
end

describe "ShopifyAPI objects" do
  
  around(:each) do |example|
    # create a temporary Shopify session
    ShopifyAPI::Session.secret = 'secret'
    ShopifyAPI::Base.site = ShopifyAPI::Session.new("domain", "token").site
    example.run
  end
  
  # test collections
  [ :asset, :blog, :comment, :country, :custom_collection, :customer_group,
    :customer, :order, :page, :product_search_engine, :product, :redirect,
    :script_tag, :smart_collection, :webhook
  ].each do |o|
    
    @class = "ShopifyAPI::" << o.to_s.split("_").collect(&:capitalize).join
    @class = @class.constantize
    
    describe @class do
      it_behaves_like "a collection"
    end
    
  end
  
  describe ShopifyAPI::Shop do
    before { @shop = ShopifyAPI::Shop.current }
    specify { @shop.should be_a ShopifyAPI::Shop }
  end
  
  # TODO: test these objects:
  # :application_charge, :article, :collect, :event, :fulfillment,
  # :image, :metafield, :province, :recurring_application_charge, 
  # :transaction, :variant
  
  
end
