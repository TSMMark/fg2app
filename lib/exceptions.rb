module Exceptions
  # thrown when a page can not handle anymore tab apps
  class TabLimitException < StandardError
    def message
      "Pages are limitted to #{Fbapp.count} tabs"
    end
  end
end