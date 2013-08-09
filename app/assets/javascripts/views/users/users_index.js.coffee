class Fg2app.Views.UsersIndex extends Backbone.View

  template: JST['users/index']

  initialize: ->
    @collection.on('reset', @render, this)

  render: ->
    $(@el).html(@template(users: @collection))
    super