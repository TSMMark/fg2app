require File.dirname(__FILE__) + '/../spec_helper'

describe Fbapp do
  it "should be valid" do
    Fbapp.new.should be_valid
  end
end
