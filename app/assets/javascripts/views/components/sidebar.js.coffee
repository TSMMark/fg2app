class Fg2app.Views.Sidebar extends Support.CompositeView

  template: FunJST('components/sidebar')

  className: 'sidebar-inner'

  initialize: ->
    super


  render:->
    @$el.html @template(something:"thing!")
    @applyLinks()

  applyLinks: =>

  collapse: (method="toggle")->
    alert method