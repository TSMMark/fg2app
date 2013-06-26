class Fg2app.Routers.Users extends Backbone.Router

  routes:
    'users/:id(/)'   : 'show'
    '(/)'            : 'index'
    #'*anything'  : 'index'
  
  initialize: ->
    @collection = new Fg2app.Collections.Users()
    @collection.fetch( reset: true )

  index: ->
    alert 'index'
    view = new Fg2app.Views.UsersIndex(collection: @collection)
    $("#container").html(view.render().el)

  show: (id)->
    alert "user #{id}"
    