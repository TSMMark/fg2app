require "spec_helper"

describe ProtectedActiveRecord do
  before(:each) do
    @tab ||= FactoryGirl.create(:tab)
    @owner ||= @tab.get_owner
    @not_owner ||= FactoryGirl.create(:user_default)
    @admin ||= FactoryGirl.create(:user_default, admin: true)
    # fields to keep 
    @keep_only = [:id, :name]

    #Tab.readable_for {|ownable| @keep_only}
  end
  
  it 'should be owner' do
    @owner.ownerable_type(@tab).should == :owner
  end

  it 'should be admin' do
    @admin.ownerable_type(@tab).should == :admin
  end

  it 'should be public' do
    @not_owner.ownerable_type(@tab).should == :public
  end

  it 'should filter against key/value pairs' do
    {id: :the_id, name: :the_name}.filter_against([:id]).should == {id: :the_id}
  end

  it '{}.delete_list([]) should delete only the list it is given' do
    hash      = {id: :the_id, name: :the_name, email: :the_email, date: :the_date}
    to_delete = [:email, :date]
    hash.delete_list to_delete
    hash.should == {id: :the_id, name: :the_name}
  end

  it 'should filter_readable_attributes' do
    readable_attrs = @tab.filter_readable_attributes(@tab.attributes, @owner)
    readable_attrs.delete_list @keep_only
    readable_attrs.should == {}
  end

  it 'should read_attributes' do
    readable_attrs = @owner.read_attributes @tab
    readable_attrs.delete_list @keep_only
    readable_attrs.should == {}
  end

end