require 'spec_helper'

describe "Logins" do
  it 'visits a page', js: true do
    visit root_path
    click_link 'Sign-In'
    sleep 1
    current_path.should == root_path
  end

  it 'alerts', js: true do
    visit '/users/1'
  end

  it 'scrolls', js: true do
    # create records
    # visit page
    # page should have content
    # scroll the page
  end
end
