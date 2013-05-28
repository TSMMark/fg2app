require File.dirname(__FILE__) + '/../spec_helper'

describe Tab do
  before do
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
    before do
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
      let(:user){ FactoryGirl.create(:admin) }

      it{ should be_able_to(:manage, Tab.new) }
      it{ should be_able_to(:read, Tab.new) }
      it{ should be_able_to(:create, Tab.new) }
      it{ should be_able_to(:update, Tab.new) }
    end
    context "when is a regular user" do
      let(:user){ FactoryGirl.create(:user_default) }

      it{ should_not be_able_to(:read, Tab.new) }
      it{ should_not be_able_to(:manage, Tab.new) }
      it{ should be_able_to(:create, Tab.new) }
      it{ should_not be_able_to(:update, Tab.new) }
    end
    context "when is a guest" do
      before { pending }

      let(:user){ User.new_guest }

      it{ should be_able_to(:read, Tab.new) }
      it{ should_not be_able_to(:manage, Tab.new) }
      it{ should_not be_able_to(:create, Tab.new) }
      it{ should_not be_able_to(:update, Tab.new) }
    end
  end
end
