module RailsExtensions
  
  class ::Hash
    # delete from this hash, a list of keys
    def delete_list list
      list.each{|k| self.delete k}
    end

    # returns only the key/value pairs where the key is in the matching array
    def filter_against matching, sensitive=false
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



end