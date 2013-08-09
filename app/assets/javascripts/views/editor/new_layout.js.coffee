class Fg2app.Views.Editor.NewLayout extends Support.CompositeView

  # sidebarBroker: Backbone.EventBroker.get 'sidebar'

  templates: 
    body: JST['editor/new_layout']

  # events:
  #   'touch .view-overlay'     : 'closeSidebars'

  # hammer: '.view-overlay'

  initialize: ->
    super

  render: =>
    @renderBody()
    .renderTopbar()
    .renderFooter()
    .renderContent()
    super

  renderBody: =>
    @$el.html @templates.body
    @

  renderContent: =>
    @

  renderTopbar: =>
    view =  new Fg2app.Views.Editor.EditorTopbar
    @renderChildInto view, @$('#top-bar')

  renderFooter: =>
    @
