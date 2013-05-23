class Fg2app.Routers.Users extends Backbone.Router

  routes:
    ''  : 'index'
    'users/:id'  : 'show'
  
  initialize: ->
    @collection = new Fg2app.Collections.Users()
    @collection.fetch({reset: true})

  index: ->
    view = new Fg2app.Views.UsersIndex(collection: @collection)
    $("#container").html(view.render().el)

  show: (id)->
    alert "user #{id}"
    