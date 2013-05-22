require File.dirname(__FILE__) + '/../spec_helper'

describe Fbapp do
  before(:each) do
    FactoryGirl.create(:fbapp)
  end

  it "has at least 1 fbapp" do
    Fbapp.all.should have_at_least(1).items
  end

end
