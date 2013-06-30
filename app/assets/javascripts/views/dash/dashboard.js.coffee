class Fg2app.Views.Dashboard.Fullpage extends Support.CompositeView

  templates: 
    body: JST['dash/dash']

  initialize: ->
    # listeners

  render: =>
    @renderBody()
    @renderSidebar()
    @renderTopbar()
    @renderMainContent()
    @


  renderBody: =>
    @$el.html @templates.body


  renderMainContent: =>
    pane  = new Fg2app.Views.Dashboard.Main()
    container = @$('#main-content')
    @renderChildInto pane, container

  renderSidebar: =>
    pane  = new Fg2app.Views.Sidebar()
    container = @$('#menu')
    @renderChildInto pane, container

  renderTopbar: =>
    pane  = new Fg2app.Views.Topbar()
    container = @$('#top-bar')
    @renderChildInto pane, container
