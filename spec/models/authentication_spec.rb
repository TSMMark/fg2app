require "spec_helper"

describe User do
  
  it "creates a user" do
    user = FactoryGirl.create(:user)
    user.should be_persisted
  end

  it "builds a user" do
    user = FactoryGirl.build(:user)
    user.should be_new_record
  end
  
  it "gets facebook info" do
    user = FactoryGirl.build(:user)
    user.should be_new_record
  end

  it "uses custom params" do
    user = FactoryGirl.build :user, :name => "peter"
    user.name.should == "peter"
  end

end