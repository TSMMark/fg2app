require File.dirname(__FILE__) + '/../spec_helper'

describe PermittedParams do
  describe :MakeArray do
    it 'makes object into array' do
      'string'.make_array.should == ['string']
    end
  end

  describe Tab do
    #subject { ability }
    before :all do
      @tab_owned        = FactoryGirl.create(:tab)
      @owner            = @tab_owned.owner
      @tab_not_owned    = FactoryGirl.create(:tab)

      # define tab parameters
      raw_params        = {:tab => {name: :tabname, description: :stillhere, fbapp_id: :a23f3fa}}
      @params           = ActionController::Parameters.new(raw_params)
      @permitted_params = PermittedParams.new(@params, @owner)
    end

    #let(:user){ @owner }
    let(:permitted_params){ @permitted_params }

    context "when is owner" do
      it 'returns all accessible fields' do
        tab_params = permitted_params.filter_for(@tab_owned)
        tab_params.should be_a Hash
        tab_params.should be_has_key(:name)
        tab_params.should be_has_key(:description)
        tab_params.should be_has_key(:fbapp_id)
      end
    end

    context "when is NOT owner" do
      it 'returns no fields' do
        tab_params = permitted_params.filter_for @tab_not_owned
        tab_params.should be_empty
      end
    end


  end

end
