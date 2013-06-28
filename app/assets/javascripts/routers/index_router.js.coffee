class Fg2app.Routers.Index extends Backbone.Router

  routes:
    '(/)'            : 'index'
    '*notFound'      : 'notFound'
  
  index: ->
    alert "main router index"

  notFound: ->
    Backbone.history.navigate('')
