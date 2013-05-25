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
  def readable_attributes ownable
    return @@is_readable_by.call ownable if @@is_readable_by.is_a? Proc
    @@is_readable_by
  end

  def prepare_readable_attributes (attrs, ownable)
    attrs.filter_against(readable_attributes ownable)
  end

  def read_attributes ownable
    self.prepare_readable_attributes(attributes, ownable)
  end

end