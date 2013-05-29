require File.dirname(__FILE__) + '/../spec_helper'

describe Tab do
  before :all do
    @tab ||= FactoryGirl.create(:tab)
    @page ||= @tab.page
    @user ||= @page.users.first
    FactoryGirl.create(:fbapp)
  end

  it "should be valid" do
    @tab.should be_valid
  end

  it "should determine owner" do
    @tab.ownerable_is_owner?(User.last).should    == true
  end

  it "should have fbapp" do
    @tab.fbapp.should be_persisted
  end

  context 'strong_parameters / permitted params' do
    before :all do
      raw_params = {:tab => {name: :tabname, description: :stillhere, fbapp_id: :a23f3fa}}
      @params = ActionController::Parameters.new(raw_params)
      @permitted_params ||= PermittedParams.new(@params, @user)
    end

    xit "should return permitted params" do
      @permitted_params.tab.ryaml
    end

  end

  require "cancan/matchers"
  describe "abilities" do
    subject { ability }
    let(:ability){ Ability.new(user) }
    let(:user){ nil }

    context "when is an admin" do
      before :all do
        @tab_owned      ||= FactoryGirl.create :tab
        @tab_not_owned  ||= FactoryGirl.create :tab
        @user           ||= @tab_owned.owner
        @user.guest     = false
        @user.admin     = true
        @user.save!
      end
      let(:user){ @user }

      context 'when admin is owner' do
        it{ should be_able_to(:read, @tab_owned) }
        it{ should be_able_to(:manage, @tab_owned) }
        it{ should be_able_to(:create, @tab_owned) }
        it{ should be_able_to(:update, @tab_owned) }
        it{ should be_able_to(:destroy, @tab_owned) }
      end

      context 'when admin is NOT owner' do
        it{ should be_able_to(:read, @tab_not_owned) }
        it{ should be_able_to(:manage, @tab_not_owned) }
        it{ should be_able_to(:create, @tab_not_owned) }
        it{ should be_able_to(:update, @tab_not_owned) }
        it{ should be_able_to(:destroy, @tab_not_owned) }
      end

    end

    context "when is a regular user" do
      before :all do
        @tab_owned      = FactoryGirl.create :tab
        @tab_not_owned  = FactoryGirl.create :tab
        @user           = @tab_owned.owner
        @user.guest     = false
        @user.save!
      end
      let(:user){ @user }

      context 'when user is owner' do
        it{ should be_able_to(:read, @tab_owned) }
        it{ should be_able_to(:manage, @tab_owned) }
        it{ should be_able_to(:create, @tab_owned) }
        it{ should be_able_to(:update, @tab_owned) }
        it{ should be_able_to(:destroy, @tab_owned) }
      end

      context 'when user is NOT owner' do
        it{ should_not be_able_to(:read, @tab_not_owned) }
        it{ should_not be_able_to(:manage, @tab_not_owned) }
        it{ should be_able_to(:create, @tab_not_owned) }
        it{ should_not be_able_to(:update, @tab_not_owned) }
        it{ should_not be_able_to(:destroy, @tab_not_owned) }
      end

    end

    context "when is a guest" do
      before :all do
        @tab_owned      = FactoryGirl.create :tab
        @tab_not_owned  = FactoryGirl.create :tab
        @user           = @tab_owned.owner
        @user.guest= true
        @user.save!
      end
      let(:user){ @user }

      context 'when guest is owner' do
        it{ should be_able_to(:read, @tab_owned) }
        it{ should be_able_to(:manage, @tab_owned) }
        it{ should be_able_to(:create, @tab_owned) }
        it{ should be_able_to(:update, @tab_owned) }
        it{ should be_able_to(:destroy, @tab_owned) }
      end

      context 'when guest is NOT owner' do
        it{ should_not be_able_to(:read, @tab_not_owned) }
        it{ should_not be_able_to(:manage, @tab_not_owned) }
        it{ should be_able_to(:create, @tab_not_owned) }
        it{ should_not be_able_to(:update, @tab_not_owned) }
        it{ should_not be_able_to(:destroy, @tab_not_owned) }
      end

    end



  end
end
