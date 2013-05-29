require File.dirname(__FILE__) + '/../spec_helper'

describe PermittedParams do
  describe :MakeArray do
    it 'should make object into array' do
      'string'.make_array.should == ['string']
    end
  end


  describe Tab do
    #subject { ability }
    before do
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
      it 'returns a list of parameters' do
        tab_params = permitted_params.params_for(@tab_owned)
        tab_params.should be_a Hash
        tab_params.should be_has_key(:name)
      end
      xit 'should list params' do
        @tab_owned.params(:public).ryaml
      end
      #it { should be_params_for(@tab_owned) }
      # it { ownerable_type_of(@owner).ryaml }
      # it "should return permitted params" do
      #   @permitted_params.ownerable_type_of(@owner).ryaml
      # end
    end


  end

end
