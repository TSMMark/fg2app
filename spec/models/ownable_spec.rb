require "spec_helper"

describe :Ownable do
  before :all do
    @tab        ||= FactoryGirl.create(:tab)
    @owner      ||= @tab.users.first
    @not_owner  ||= FactoryGirl.create(:user_default)
    @guest      ||= User.new_guest
  end

  describe 'new tab' do
    before do
      @tab        ||= Tab.new(page_id: FactoryGirl.create(:page))
      @owner      ||= @tab.owners.first
      @not_owner  ||= @not_owner
    end

    context 'when it has no page' do
      before do
        @tab    = Tab.new()
      end

      it 'owners is empty' do
        @tab.owners.should be_empty
      end

      it 'anyone can be owner' do
        @tab.ownerable_is_owner?(@not_owner).should be_true
      end

      it 'guest can be owner' do
        @tab.ownerable_is_owner?(@guest).should be_true
      end
    end

    context 'when it has a page' do
      it 'has owners' do
        @tab.owners.should_not be_empty
      end

      it 'owner is recognized' do
        @tab.ownerable_is_owner?(@owner).should be_true
      end

      it 'not owner is not owner' do
        @tab.ownerable_is_owner?(@not_owner).should be_false
      end

      it 'guest is not owner' do
        @tab.ownerable_is_owner?(@guest).should be_false
      end
    end
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

  xit "should have an owner with create privileges" do
    @owner.can_create?(@tab).should == true
  end

  it "should get user_type relative to an object" do
    @owner.ownerable_type(@tab).should == :owner
  end

end