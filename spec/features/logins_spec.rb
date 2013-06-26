require 'spec_helper'

describe "Logins" do
  it 'visits a page' do
    visit root_path
    click_link 'Sign-In'
    current_path.should == root_path
  end

  it 'alerts', js: true do
    visit '/users/1'
  end
end
