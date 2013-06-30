class Fg2app.Views.Sidebar extends Support.CompositeView

  template: JST['components/sidebar']

  className: 'collapse-inner'
  # id: 'menu'
  # className: 'menu nav-collapse collapse width'

  initialize: ->


  render:->
    @$el.html @template