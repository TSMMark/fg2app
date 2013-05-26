module RailsExtensions
  #    Class    #
  class ::Class
    # define multiple similar methods like so
    #   def_each :failure, :error, :success do |method_name|
    #     self.state = method_name
    #   end
    def def_each(*method_names, &block)
      method_names.each do |method_name|
        define_method method_name do
          instance_exec method_name, &block
        end
      end
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

    # raises object to_yaml
    def ryaml
      raise self.to_yaml
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