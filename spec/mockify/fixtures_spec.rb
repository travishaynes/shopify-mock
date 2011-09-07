require 'spec_helper'

describe Mockify::Fixtures do
  
  context "when given a valid fixture name" do
    it "should return the contents of a fixture" do
      @xml = read_fixture :test
      Mockify::Fixtures.read(:test).should eq @xml
    end
  end
  
  context "when given an invalid fixture name" do
    it "should raise an error" do
      expect { Fixtures.read(:brown_chicken_brown_cow) }.should raise_error
    end
  end
  
end
