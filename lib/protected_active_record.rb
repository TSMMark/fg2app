class ProtectedActiveRecord < ActiveRecord::Base
  self.abstract_class = true
  include Ownable

  @@is_readable_for = true
  @@get_owners_proc = Proc.new {|ownable| ownable.users}

  # CLASS METHODS / GLobal Setters
  # define how to get owners (defaults to self.users)
  def self.owners_are &block
    @@get_owners_proc = block
  end

  # determine attrs that a user can read
  def self.readable_for_block &block
    @@is_readable_for = block
  end
  def self.readable_for_hash hash
    self.readable_for hash
  end
  def self.readable_for val
    @@is_readable_for = val
  end

  def readable_attributes ownerable=nil
    o_type = ownerable.ownerable_type(self)
    case @@is_readable_for
      when Proc
        return @@is_readable_for.call o_type, self
      when Hash
        return @@is_readable_for[o_type]
      else
        return @@is_readable_for
    end

    #return @@is_readable_for.call if @@is_readable_for.is_a? Proc
    #return @@is_readable_for[ownerable.ownerable_type(self)] if 
    #@@is_readable_for.call_or_value ownerable.ownerable_type(self)
  end

  def filter_readable_attributes (attrs, ownerable=nil)
    attrs.filter_against(readable_attributes ownerable)
  end

  def read_attributes ownerable=nil
    self.filter_readable_attributes(attributes, ownerable)
  end


  # get array of owners
  def get_owners
    #raise @@get_owners_proc.to_yaml
    @@get_owners_proc.call_or_value self
  end
  # get last owner
  def get_owner
    self.get_owners.last
  end

  # alias get_owner
  def owner
    self.get_owner
  end
  # alias get_owners
  def owners
    self.get_owners
  end


end