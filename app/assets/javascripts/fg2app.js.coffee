window.Support  = {}
window.Fg2app   =
  $:{}
  Models: {}
  Collections: {}
  Views:
    Dashboard:{}
    
  Routers: {}
  Dispatcher: {}
  initialize: ->
    @$.container = $("#app-content")
    # Index Router must be initialized FIRST
    #   so that it is checked LAST
    new Fg2app.Routers.Index()
    new Fg2app.Routers.Users()
    # new Fg2app.Routers.Tabs()
    Backbone.history.start
      pushState: typeof window.history.pushState is not 'undefined'

$(document).ready ->
  Fg2app.initialize()
  document.addEventListener "touchstart", (->), true

Browser.hideAddressBar();
