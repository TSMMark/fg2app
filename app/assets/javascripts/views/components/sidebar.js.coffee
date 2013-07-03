class Fg2app.Views.Sidebar extends Support.CompositeView

  template: JST['components/sidebar']

  className: 'collapse-inner'
  # id: 'menu'
  # className: 'menu nav-collapse collapse width'

  initialize: ->


  render:->
    @$el.html @template()
    # @$(".self-portrait").css("background-image", "url(//graph.facebook.com/jeffrey.folker/picture?width=120&height=120)")
    @applyLinks()

  applyLinks: =>
    # @$(".link-settings").attr("href", Paths.omniauth_facebook)

  collapse: (method="toggle")->
    alert method