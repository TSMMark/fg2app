require "spec_helper"

describe User do
  
  xit "is pending" do
    
  end
  
  it "creates a user" do
    user = FactoryGirl.create(:user)
    user.should be_persisted
  end

  it "builds a user" do
    user = FactoryGirl.build(:user)
    user.should be_new_record
  end
  
end