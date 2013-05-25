require "spec_helper"

describe ProtectedActiveRecord do
  before(:each) do
    @tab ||= FactoryGirl.create(:tab)
    @owner ||= @tab.get_owner
  end

  it 'should store block' do
    Tab.readable_when {|ownable| ownable}
    raise @tab.readable_attributes(@owner).to_yaml
  end

  it 'should filter against key/value pairs' do
    {id: :the_id, name: :the_name}.filter_against([:id]).should == {id: :the_id}
  end

  it 'should prepare_readable_attributes' do
    Tab.readable_when {|ownable| [:id]}
    readable_attrs = @tab.prepare_readable_attributes(@tab.attributes, @owner)
    readable_attrs.has_key?(:id).should == true
    readable_attrs.has_key?(:name).should == false
  end

end