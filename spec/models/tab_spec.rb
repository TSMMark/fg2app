require File.dirname(__FILE__) + '/../spec_helper'

describe Tab do
  before :all do
    @tab ||= FactoryGirl.create(:tab)
    @page ||= @tab.page
    @user ||= @page.users.first
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

  context "when tab limit exceeded" do
    before do
      # FactoryGirl.create(:tab, page: @page)
    end

    it 'gets a different tab app' do

    end

    it 'raises error' do
      13.times do
        if(@page.tabs.count >= 12)
          lambda { Tab.create(page: @page) }.should raise_exception
        else
          Tab.create(page: @page)
        end
      end
    end

  end

  describe "abilities" do
    before do
      @ability = Ability.new(@user)
    end
    subject { ability }
    let(:ability){ @ability }
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

      context 'accessible_by' do
        xit 'raises' do
          Tab.accessible_by(@ability).all.ryaml
        end

        it 'returns array which includes an owned tab' do
          Tab.accessible_by(@ability).all.should be_include(@user.tabs.last)
        end
        it 'returns array which does not include an un-owned tab' do
          Tab.accessible_by(@ability).all.should_not be_include(@tab)
        end
      end

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
        it{ should_not be_able_to(:create, @tab_not_owned) }
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
        it{ should_not be_able_to(:create, @tab_not_owned) }
        it{ should_not be_able_to(:update, @tab_not_owned) }
        it{ should_not be_able_to(:destroy, @tab_not_owned) }
      end

    end


  context 'strong_parameters / permitted params' do
    before :all do
      pending
      raw_params = {:tab => {name: :tabname, description: :stillhere}}
      @params = ActionController::Parameters.new(raw_params)
      @permitted_params ||= PermittedParams.new(@params, @user)
    end

    it "should return permitted params" do
      @permitted_params.tab.ryaml
    end

  end


  end
end
