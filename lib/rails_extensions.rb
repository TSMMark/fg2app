module RailsExtensions
  
  class ::Hash
    # returns only the key/value pairs where the key is in the matching array
    def filter_against matching, sensitive=false
      # return complete hash if (matching==true)
      return self if(matching==true)
      # return empty hash if (matching==false)
      return {}   if(matching==false)
      #.insensitive
      {}.insensitive.tap do |new_hash|
        self.insensitive.tap do |orig|
          matching.each do |key|
            new_hash[key] = orig[key] if orig.has_key?(key)
          end
        end
      end
    end

  end



end