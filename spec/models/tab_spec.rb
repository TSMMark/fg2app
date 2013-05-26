require File.dirname(__FILE__) + '/../spec_helper'

describe Tab do
  before(:each) do
    @tab ||= FactoryGirl.create(:tab)
    FactoryGirl.create(:fbapp)
  end

  it "should be valid" do
    @tab.should be_valid
  end

  it "should determine owner" do
    @tab.ownerable_is_owner?(User.last).should    == true
  end

  xit "should determine user editable" do
    @tab.user_can_update?(User.last).should  == true
  end

  it "should have fbapp" do
    @tab.fbapp.should be_persisted
  end



end
