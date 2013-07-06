class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name,
    :admin, :guest,
    :created_at, :updated_at,
    :sign_in_count,
    :current_sign_in_at, :last_sign_in_at,
    :current_sign_in_ip, :last_sign_in_ip
end
