require "spec_helper"

describe User do
  
  xit "is pending" do
    
  end
  
  xit "creates a user" do
    user = FactoryGirl.create(:user)
    user.should be_persisted
  end

  xit "builds a user" do
    user = FactoryGirl.build(:user)
    user.should be_new_record
  end
  
  xit "gets facebook info" do
    user = FactoryGirl.build(:user)
    user.should be_new_record
  end

  xit "uses custom params" do
    user = FactoryGirl.build :user, :name => "peter"
    user.name.should == "peter"
  end

end