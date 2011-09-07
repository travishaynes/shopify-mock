require 'spec_helper'

describe :response do
  
  
  describe "all registered responses" do
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
end
