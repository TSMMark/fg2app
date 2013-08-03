window.Support  = 
  Mixin: {}
  
window.Global ||= {}
window.Dispatch = _.extend {}, Backbone.Events
window.Fg2app   =
  env:          null
  $:            {}
  Routers:      {}
  Models:       {}
  Collections:  {}
  
  Views:
    Elements:   {}
    Dashboard:  {}
    

  initialize: ->
    @$.container  = $("#app-content")
    # Index Router must be initialized FIRST
    #   so that it is checked LAST
    new Fg2app.Routers.Index()
    # new Fg2app.Routers.Users()
    # new Fg2app.Routers.Tabs()
    Backbone.history.start
      pushState: typeof window.history.pushState isnt 'undefined'

$(document).ready ->
  Fg2app.initialize()
  document.addEventListener "touchstart", (->), true

Browser.hideAddressBar();
