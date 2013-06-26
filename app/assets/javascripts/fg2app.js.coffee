window.Fg2app =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
    new Fg2app.Routers.Users()
    Backbone.history.start( pushState: true )
    #route = $("#container").data("route")
    #Backbone.history.navigate(route) if route && route != Backbone.history.fragment

$(document).ready ->
  Fg2app.initialize()
