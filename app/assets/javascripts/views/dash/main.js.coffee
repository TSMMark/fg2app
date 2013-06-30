class Fg2app.Views.Dashboard.Main extends Support.CompositeView

  template: JST['dash/main']
  id: 'main-content'

  initialize: ->
    # listeners

  render: =>
    @$el.html @template