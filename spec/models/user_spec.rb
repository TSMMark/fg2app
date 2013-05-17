require "spec_helper"

describe User do
  # xit makes pending

  it "creates a user" do
    user = FactoryGirl.create(:user_with_auth)
    user.should be_persisted
  end

  it "uses custom params" do
    user = FactoryGirl.create :user_with_auth, :name => "peter"
    user.name.should == "peter"
  end

  it "has one auth" do
    user = FactoryGirl.create(:user_with_auth)
    user.authentications.should have(1).items
  end

  context 'scopes' do
    xit '.facebook should return filter provider by facebook' do
      Authentication.facebook.where_values_hash[:provider].should == 'facebook'
    end

    xit '.facebook should return facebook auth' do
      user = FactoryGirl.create :user_with_auth
      user.fb_auth.should be_persisted
    end

  end

  context 'facebook' do
    it "fetches facebook name" do
      user = FactoryGirl.create(:user_with_auth)
      user.fetch_fb.name.should have_at_least(3).characters
    end

  end


end