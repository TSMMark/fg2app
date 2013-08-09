class Fg2app.Routers.Users extends Backbone.Router

  routes:
    'users/:id(/)'   : 'show'
  
  initialize: ->
    @collection = new Fg2app.Collections.Users()
    @collection.fetch( reset: true )

  index: ->
    alert 'index'
    view = new Fg2app.Views.UsersIndex(collection: @collection)
    Fg2app.$container.html(view.render().el)

  notFound: ->
    Backbone.history.navigate('')
    
  show: (id)->
    alert "user #{id}"
    