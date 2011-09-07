require 'spec_helper'

describe :response do
  
  
  describe "all registered responses (json)" do
    ShopifyAPI::Mock::Fixtures.all.each do |fixture|
      describe "##{fixture}" do
        describe "GET /#{fixture}.json" do
          before do
            @json = read_fixture fixture
            @response = get fixture
          end
          it "should return #{fixture.to_s}.json fixture" do
            @response.body.should eq @json
          end
        end
        
        describe "GET /#{fixture}/count.json" do
          before do
            @json = read_fixture :count
            @response = get [fixture, :count]
          end
          it "should return count json" do
            @response.body.should eq @json
          end
        end
      end
    end
  end
  
  describe "all registered responses (xml)" do
    ShopifyAPI::Mock::Fixtures.all(:xml).each do |fixture|
      describe "##{fixture}" do
        describe "GET /#{fixture}.xml" do
          before do
            @xml = read_fixture fixture, :xml
            @response = get fixture, :ext => :xml
          end
          it "should return #{fixture.to_s}.xml fixture" do
            @response.body.should eq @xml
          end
        end
        
        describe "GET /#{fixture}/count.xml" do
          before do
            @xml = read_fixture :count, :xml
            @response = get [fixture, :count], :ext => :xml
          end
          it "should return count xml" do
            @response.body.should eq @xml
          end
        end
      end
    end
  end
end
