require "zombie"
describe Zombie do

  xit "is pending" do
    
  end

  it "is named Ash" do
    zombie = Zombie.new
    zombie.name.should == 'Ash'
  end

  it "has no brains" do
    zombie = Zombie.new
    zombie.brains.should_not > 1
  end

end