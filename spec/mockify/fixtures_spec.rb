require 'spec_helper'

describe Mockify::Fixtures do
  
  context "when given a valid fixture name" do
    it "should return the contents of a fixture" do
      @json = read_fixture :test
      Mockify::Fixtures.read(:test).should eq @json
    end
  end
  
  context "when given an invalid fixture name" do
    it "should raise an error" do
      expect { Mockify::Fixtures.read(:brown_chicken_brown_cow) }.should raise_error
    end
  end
  
  context "custom fixtures" do
    before { @json = '{ "count": 10 }' }
    describe "#use" do
      it "should override default fixture" do
        Mockify::Fixtures.read(:orders).should eq read_fixture :orders
        Mockify::Fixtures.use :count, @json
        Mockify::Fixtures.read(:count).should eq @json
      end
    end
  end
  
end
