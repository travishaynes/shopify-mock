require 'spec_helper'

describe :orders do
  
  describe "GET /orders.json" do
    before do
      @json = read_fixture :orders
      @response = get :orders
    end
    it "should return orders.json fixture" do
      @response.body.should eq @json
    end
  end
  
  describe "GET /orders/count.json" do
    before do
      @json = read_fixture :count
      @response = get [:orders, :count]
    end
    it "should return count json" do
      @response.body.should eq @json
    end
  end
  
end
