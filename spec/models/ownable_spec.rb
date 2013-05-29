require "spec_helper"

describe :Ownable do
  before do
    @tab ||= FactoryGirl.create(:tab)
    @owner ||= @tab.users.first
  end

  it "should have current user" do
    @tab.ownable?.should == true
  end

  it "should extend ownable" do
    @tab.ownable?.should == true
  end

  it "should have at least one owner" do
    @tab.users.should have_at_least(1).items
  end

  it "should extend ownable" do
    @tab.should be_ownable
  end

  it "should have an owner which is ownerable" do
    @owner.should be_ownerable
  end

  it "should have an owner with create privileges" do
    @owner.can_create?(@tab).should == true
  end

  it "should get user_type relative to an object" do
    @owner.ownerable_type(@tab).should == :owner
  end

end