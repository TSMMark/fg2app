class Api::V1::BaseController < Api::BaseController

  def respond_with object, *args
    super :api, :v1, object, *args
  end

end