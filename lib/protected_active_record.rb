class ProtectedActiveRecord < ActiveRecord::Base
  self.abstract_class = true
  include Ownable

  def initialize
    @@is_readable_when = true
    super
  end
  def self.readable_when &block
    @@is_readable_when = block
  end
  def readable_attributes ownable
    return @@is_readable_when.call ownable if @@is_readable_when.is_a? Proc
    @@is_readable_when
  end

  def prepare_readable_attributes (attrs, ownable)
    #raise readable_attributes(ownable).to_yaml
    attrs.filter_against(readable_attributes ownable)
  end

  def read_attributes ownable
  end

end