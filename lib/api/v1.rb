module Api
  module V1

    module Page
      extend ActiveSupport::Concern
      included do
        define_api  [:public, :guest],[
                      :id]
        define_api  [:owner, :admin],[
                      :id, :name, :pid, :category,
                      :created_at, :updated_at]
      end
    end

    module User
      extend ActiveSupport::Concern
      included do
        define_api  [:public, :guest], [
                      :id]
        define_api  [:owner, :admin], [
                      :id, :name, :email, :admin,
                      :created_at, :updated_at,
                      :current_sign_in_at, :last_sign_in_at,
                      :current_sign_in_ip, :last_sign_in_ip]
      end

    end

  end
end