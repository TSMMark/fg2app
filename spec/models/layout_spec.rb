require 'spec_helper'

describe Layout do
  describe 'factory' do
    before do
      @layout = FactoryGirl.create(:layout_default)
    end
    
    let(:layout){ FactoryGirl.create(:layout_default) }
    xit{ should be_persisted }

    it 'persists' do
      @layout.should be_persisted
    end

    it 'has a user' do
      @layout.users.should have(1).items
    end

    it 'has a user' do
      @layout.users.should have(1).items
    end

  end

  describe 'Abilities' do
    describe "Regular User" do
      before :all do
        @owned      ||= FactoryGirl.create :layout
        @not_owned  ||= FactoryGirl.create :layout
        @user       ||= @owned.users.first
        @user.guest = false
        @user.save!
      end

      let(:ability){ Ability.new(@user) }
      subject { ability }
      let(:user){ @user }

      context 'when is owner' do
        it{ should be_able_to(:read, @owned) }
        it{ should be_able_to(:manage, @owned) }
        it{ should be_able_to(:create, @owned) }
        it{ should be_able_to(:update, @owned) }
        it{ should be_able_to(:destroy, @owned) }
      end

      context 'when is NOT owner' do
        it{ should_not be_able_to(:read, @not_owned) }
        it{ should_not be_able_to(:manage, @not_owned) }
        it{ should_not be_able_to(:create, @not_owned) }
        it{ should_not be_able_to(:update, @not_owned) }
        it{ should_not be_able_to(:destroy, @not_owned) }
      end

    end

  end

end
