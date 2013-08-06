class Fg2app.Views.Dashboard.Fullpage extends Support.CompositeView

  templates: 
    body: JST['dash/dash']

  initialize: ->
    # listeners

  render: =>
    @renderBody()
    @renderMainContent()
    @renderSidebar()
    @renderTopbar()
    @

  renderBody: =>
    @$el.html @templates.body


  renderMainContent: =>
    pane  = new Fg2app.Views.Dashboard.Main()
    container = @$('#main-content-container')
    @renderChildInto pane, container

  renderSidebar: =>
    pane  = new Fg2app.Views.Sidebar()
    container = @$('#menu-left')
    @renderChildInto pane, container

  renderTopbar: =>
    pane  = new Fg2app.Views.DashTopbar( route: 'dash')
    container = @$('#top-bar')
    @renderChildAs pane, container
