window.Fg2app =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
    new Fg2app.Routers.Users()
    Backbone.history.start()

$(document).ready ->
  Fg2app.initialize()
