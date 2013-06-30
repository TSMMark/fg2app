window.Support  = {}
window.Fg2app   =
  $:{}
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  Dispatcher: {}
  initialize: ->
    @$.container = $("#container")
    # Index Router must be initialized FIRST
    #   so that it is checked LAST
    new Fg2app.Routers.Index()
    new Fg2app.Routers.Users()
    # new Fg2app.Routers.Tabs()
    Backbone.history.start( pushState: true )

$(document).ready ->
  Fg2app.initialize()
