require File.dirname(__FILE__) + '/../spec_helper'

describe Page do
  
  before(:each) do
    @page ||= FactoryGirl.create(:page)
  end

  it "creates a page" do
    @page.should be_persisted
  end
  
  it "should be valid" do
    Page.new.should be_valid
  end
  
  it "should generate n users" do
    @page.users.length.should have_at_least(5).items
  end

  it "can reference parent users" do
    @page.users.first.name.should have_at_least(3).characters
  end
  
  it "can reference user tokens" do
    user  = @page.users.first
    @page.token(user).should have(1).items
  end

end
