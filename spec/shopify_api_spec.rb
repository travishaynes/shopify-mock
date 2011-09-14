require 'spec_helper'
require 'xml' # libxml-ruby gem

shared_examples "a collection" do
  let(:collection) { 
    described_class.all 
  }
  
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
  [ :blog, :comment, :country, :custom_collection, :customer_group,
    :customer, :order, :page, :product_search_engine, :product, :redirect,
    :script_tag, :smart_collection, :theme, :webhook
  ].each do |o|
    
    @class = "ShopifyAPI::" << o.to_s.classify
    @class = @class.constantize
    
    describe @class do
      it_behaves_like "a collection"
    end
    
  end

  # still to test
  # :articles, :events, :fulfillments,:variants, :transactions :provinces, :images, :metafields,
  # test find on classes which have ids
  [:blogs, :comments, :countries,  :customers,  :orders, :pages, :products, 
   :redirects, :themes, :webhooks].each do |o|
    describe 'find by :id.json' do
      it "find #{o}/:id.json should return a ShopifyAPI::#{o.to_s.singularize.classify} item with the right id" do
        
        clz = "ShopifyAPI::" << o.to_s.singularize.classify
        clz = clz.constantize
        
        first_item = JSON.parse(ShopifyAPI::Mock::Fixture.find(o, :json).data)[o.to_s].first
        found = clz.find(first_item['id'].to_i)
        found.should be_a clz
        found.id.should == first_item['id']
      end
    end
    describe 'find by :id.xml' do
      it "find #{o}/:id.xml should return a ShopifyAPI::#{o.to_s.singularize.classify} item with the right id" do
        
        # grab id from fixture which we'll use to compare with the actual results from find
        fixture_xml = XML::Document.string(ShopifyAPI::Mock::Fixture.find(o, :xml).data)
        finder = "//#{o.to_s}/#{o.to_s.singularize}/id"
        first_item_id = fixture_xml.find_first(finder).content.to_i

        clz = "ShopifyAPI::" << o.to_s.singularize.classify
        clz = clz.constantize

        found = clz.find(first_item_id)
        found.should be_a clz
        found.id.should == first_item_id
      end
    end

  end

  # still to test
  # :articles, :events, :fulfillments,:variants, :transactions :provinces, :images, :metafields,
  # test find on classes which have ids
  [:blogs, :comments, :countries, :custom_collections, :customer_groups,
   :customers,  :orders, :pages, :products,  :redirects, :script_tags, 
   :smart_collections, :themes, :webhooks].each do |o|

    it "find #{o}/:id.json should return a ShopifyAPI::#{o.to_s.singularize.classify} item with the right id" do
    
      clz = "ShopifyAPI::" << o.to_s.singularize.classify
      clz = clz.constantize
    
      first_item = JSON.parse(ShopifyAPI::Mock::Fixture.find(o, :json).data)[o.to_s].first
      found = clz.find(first_item['id'].to_i)
      found.should be_a clz
      found.id.should == first_item['id']
    end
  end

  describe ShopifyAPI::Shop do
    before { @shop = ShopifyAPI::Shop.current }
    specify { @shop.should be_a ShopifyAPI::Shop }
  end
  
  # TODO: test these objects:
  # :asset, :application_charge, :article, :collect, :event, :fulfillment,
  # :image, :metafield, :province, :recurring_application_charge, 
  # :transaction, :variant

  
end
