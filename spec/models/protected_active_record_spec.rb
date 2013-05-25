require "spec_helper"

describe ProtectedActiveRecord do
  before(:each) do
    @tab ||= FactoryGirl.create(:tab)
    @owner ||= @tab.get_owner
    @keep_only = [:id, :name]
    Tab.readable_by {|ownable| @keep_only}
  end

  it 'should filter against key/value pairs' do
    {id: :the_id, name: :the_name}.filter_against([:id]).should == {id: :the_id}
  end

  it 'should prepare_readable_attributes' do
    readable_attrs = @tab.prepare_readable_attributes(@tab.attributes, @owner)
    readable_attrs.delete_list @keep_only
    readable_attrs.should == {}
  end

  it 'should read_attributes' do
    readable_attrs = @owner.read_attributes @tab
    readable_attrs.delete_list @keep_only
    readable_attrs.should == {}
  end

end