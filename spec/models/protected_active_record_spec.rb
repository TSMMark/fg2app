require "spec_helper"

describe ProtectedActiveRecord do
  before(:each) do
    @tab ||= FactoryGirl.create(:tab)
    @owner ||= @tab.get_owner
    @not_owner ||= FactoryGirl.create(:user_default)
    @admin ||= FactoryGirl.create(:admin)
    # fields to keep 
    @keep_only = [:id, :name]

    #Tab.readable_for {|ownable| @keep_only}
  end
  
  it 'fill_with! should fill hash with default values' do
    {}.fill_with!(:blu, [:admin,:owner]).should == {admin: :blu, owner: :blu}
  end
  it 'should be owner' do
    @owner.ownerable_type(@tab).should == :owner
  end
  it 'should return owner fields' do
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

  it 'should filter_readable' do
    readable_attrs = @tab.filter_readable(@tab.attributes, @owner)
    readable_attrs.delete_list @keep_only
    readable_attrs.should == {}
  end

  it 'should crud_action_read' do
    readable_attrs = @tab.crud_action_read @owner
    readable_attrs.delete_list @keep_only
    readable_attrs.should == {}
  end

  it 'should crud_action_create new record with filtered fields' do
    tab = FactoryGirl.build(:tab)
    owner = tab.owner
    tab.tap do |tab|
      attrs = {:name => "butt", :description => "descut"}
      tab.crud_action_create attrs, owner
    end
    tab.ryaml
  end

end