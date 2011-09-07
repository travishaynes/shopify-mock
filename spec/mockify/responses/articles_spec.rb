require 'spec_helper'

describe :articles do
  
  describe "GET /articles.json" do
    before do
      @json = read_fixture :articles
      @response = get :articles
    end
    it "should return articles.json fixture" do
      @response.body.should eq @json
    end
  end
  
  describe "GET /articles/count.json" do
    before do
      @json = read_fixture :count
      @response = get [:articles, :count]
    end
    it "should return count json" do
      @response.body.should eq @json
    end
  end
  
end
