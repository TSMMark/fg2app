class ProtectedActiveRecord < ActiveRecord::Base
  self.abstract_class = true
  include Ownable

  def initialize
    @@is_readable_by = true
    super
  end

  def self.readable_by &block
    @@is_readable_by = block
  end

  def readable_attributes ownerable=nil
    @@is_readable_by.call_or_value ownerable
  end

  def filter_readable_attributes (attrs, ownerable=nil)
    attrs.filter_against(readable_attributes ownerable)
  end

  def read_attributes ownerable=nil
    self.filter_readable_attributes(attributes, ownerable)
  end

end