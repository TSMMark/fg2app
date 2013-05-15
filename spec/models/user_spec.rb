require "spec_helper"

describe User do
  
  xit "is pending" do
    
  end
  
  it "is named Ash" do
    zombie = User.new(name: "Ash")
    zombie.name.should == 'Ash'
  end
  
end