class Fg2app.Views.Dashboard extends Support.CompositeView

  templates: 
    body: JST['dash/dash']

  initialize: ->
    # listeners

  render: =>
    @renderBody()
    @renderSidebar()
    @renderTopbar()
    @


  renderBody: =>
    @$el.html @templates.body


  renderSidebar: =>

  renderTopbar: =>
    topBar  = new Fg2app.Views.Topbar()
    topbarContainer = @$('#top-bar')
    @renderChildInto topBar, topbarContainer
