# strong_parameters initializer
ActiveRecord::Base.send(
  :include, ActiveModel::ForbiddenAttributesProtection
)