class TabSerializer < ActiveModel::Serializer
  attributes  :id, :name, :description, :created_at, :updated_at,
              :page_id, :fbapp_id
end
