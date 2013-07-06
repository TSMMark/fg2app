require File.dirname(__FILE__) + '/../spec_helper'

describe Fbapp do

  context "all the time" do
    it "has 12 fbapp" do
      Fbapp.count.should == 12
    end
  end

end
