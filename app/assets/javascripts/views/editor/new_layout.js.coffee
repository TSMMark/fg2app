class Fg2app.Views.Editor.NewLayout extends Support.CompositeView

  # sidebarBroker: Backbone.EventBroker.get 'sidebar'

  templates: 
    body: JST['editor/new_layout']

  initialize: ->
    super
    Helper.establishSidebars [], Fg2app.$body

  render: =>
    @renderBody()
    .renderTopbar()
    .renderFooter()
    .renderContent()
    super

  renderBody: =>
    @$el.html @templates.body
    @

  renderTopbar: =>
    view =  new Fg2app.Views.Editor.EditorTopbar()
    @renderChildInto view, @$('#top-bar')

  renderFooter: =>
    view =  new Fg2app.Views.Editor.EditorFooter()
    @renderChildInto view, @$('#footer')

  renderContent: =>
    @
