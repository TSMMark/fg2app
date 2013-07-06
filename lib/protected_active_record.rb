class ProtectedActiveRecord < ActiveRecord::Base
  self.abstract_class = true
  include Ownable

  @@get_owners_proc = Proc.new {|ownable| ownable.users}

  # CLASS METHODS / GLobal Setters
  # define how to get owners (defaults to self.users)
  def self.owners_are &block
    @@get_owners_proc = block
  end

  @@CRUD_for  = { create:   true,
                  read:     true,
                  update:   true,
                  destroy:  true
                }#.insensitive

  # specify how to determine attrs that a user can read
  def self.crud_for (access, value)
    if value.is_a? Hash then
      self.crud_for_hash access, value
    else
      @@CRUD_for[access] = value
    end
  end
  def self.crud_for_hash (access, hash)
    init_crud_attrs access unless @@CRUD_for[access].is_a? Hash
    @@CRUD_for[access].merge! hash
  end
  def self.crud_for_block (access, &block)
    self.crud_for access, block
  end

  # use the predetermined crud_for specifications
  def crud_check (access, ownerable=nil)
    o_type = self.ownerable_type_of(ownerable)
    case @@CRUD_for[access]
      when Proc
        return @@CRUD_for[access].call o_type, self
      when Hash
        return @@CRUD_for[access][o_type]
      else
        return @@CRUD_for[access]
    end
  end
  def filter_crud_attributes(access, attrs, ownerable=nil)
    permitted_attributes  = self.crud_check access
    # true / false check within filter_against
    attrs.filter_against(permitted_attributes, ownerable)
  end
  def crud_action_read(ownerable=nil)
    self.filter_crud_attributes(:read, self.attributes, ownerable)
  end
  def crud_action_create(attrs=nil, ownerable=nil)
    attrs = self.filter_crud_attributes(:create, attrs, ownerable)
    self.update_attributes attrs
    self.save!
  end



  @@CRUD_for.each_key do |access|
    # class methods
    # define class methods to set CRUD rules from the ActiveModel
    # readable_for, createable_for_hash, updateable_for_block
    define_singleton_method "#{access}able_for" do |val|
      self.crud_for access, val
    end
    define_singleton_method "#{access}able_for_hash" do |hash|
      self.crud_for_hash access, hash
    end
    define_singleton_method "#{access}able_for_block" do |&block|
      self.crud_for access, block
    end

    # instance methods
    # get list of fields
    define_method "#{access}able" do |ownerable|
      self.crud_check access, ownerable
    end
    # filter out protected fields from a hash of fields: :values
    define_method "filter_#{access}able" do |attrs, ownerable=nil|
      self.filter_crud_attributes access, attrs, ownerable
    end
  end






  #    OWNER STUFF    #
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

  protected
  def self.init_crud_attrs access
    before  = !!@@CRUD_for[access]
    @@CRUD_for[access]  = {}.fill_with!(before, [:admin, :owner, :guest, :public])
  end


end