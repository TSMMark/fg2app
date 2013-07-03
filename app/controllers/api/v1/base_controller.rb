class Api::V1::BaseController < Api::BaseController

  def respond_with *params
    super :v1, *params
  end

end