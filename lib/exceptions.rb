module Exceptions
  # thrown when a page can not handle anymore tab apps
  class TabLimitException < StandardError
    def message
      "Pages are limitted to #{Fbapp.count} tabs"
    end
  end

  # throw when user must be signed in to do something
  class NotSignedInException < StandardError
    def message
      "You can only do this when signed in"
    end
  end

end