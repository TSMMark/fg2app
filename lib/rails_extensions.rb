module RailsExtensions
  class ::Symbol
    def constantize camel=true
      s = self.to_s
      s = s.camelize if camel
      s.constantize
    end
  end


  #    Class    #
  class ::Class
    # underscore and convert class name to symbol
    def name_to_sym
      self.name.underscore.to_sym
    end
  end
  # .. Class .. #

  #    Object    #
  class ::Object
    # if self is a proc call it with params, otherwise just return self
    def call_or_value *params
      return self.call(*params) if self.is_a? Proc
      self
    end
    
    # class_name_to_sym
    def class_name_to_sym
      self.class.name.underscore.to_sym
    end

    # raises object to_yaml
    def ryaml
      raise self.to_yaml
    end

    def make_array
      return self if self.is_a? Array
      return [self]
    end
  end
  # .. Object .. #


  #    Hash    #
  class ::Hash

    # fill hash with default values
    def fill_with!(default=nil, keys=nil)
      if !keys then
        self.each_key {|key| self[key]=default}
      else
        keys.each {|key| self[key] = default}
      end
      self
    end

    # delete from this hash, a list of keys
    def delete_list list
      list.each{|k| self.delete k}
    end

    # returns only the key/value pairs where the key is in the matching array
    def filter_against (matching, sensitive=false)
      myself = self
      final  = {}
      if(!sensitive) then
        myself = myself.insensitive
        final  = final.insensitive
      end
      
      # return complete hash if (matching==true)
      return self if(matching==true)
      # return empty hash if (matching==false)
      return {}   if(matching==false)
      
      final.tap do |final|
        matching.each do |key|
          final[key] = myself[key] if myself.has_key?(key)
        end
      end
    end

  end
  # .. Hash .. #



end