class PageSerializer < ActiveModel::Serializer
  attributes  :id, :pid, :name, :category,
              :created_at, :updated_at, :tabs
end
