module RailsExtensions
  
  class ::Hash
    # returns only the key/value pairs where the key is in the matching array
    def filter_against matching
      # return complete hash if (matching==true)
      return self if(matching==true)
      # return empty hash if (matching==false)
      return {}   if(matching==false)
      {}.tap do |new_hash|
        matching.each do |key|
          new_hash[key] = self[key] if self.has_key?(key)
        end
      end
    end

  end



end