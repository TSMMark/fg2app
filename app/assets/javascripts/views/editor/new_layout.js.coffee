class Fg2app.Views.Editor.NewLayout extends Support.CompositeView

  # sidebarBroker: Backbone.EventBroker.get 'sidebar'

  templates: 
    body: JST['editor/new_layout']

  # events:
  #   'touch .view-overlay'     : 'closeSidebars'

  # hammer: '.view-overlay'

  initialize: ->
    super
    # listeners
    # @sidebarBroker.register 
    #   'left.toggle'   : 'toggleSidebarLeft'
    #   'right.toggle'  : 'toggleSidebarRight'
    #   ,@

  render: =>
    @renderBody()
    @renderTopbar()
    @renderFooter()
    @renderContent()
    super

  renderBody: =>
    @$el.html @templates.body

  renderContent: =>


  renderTopbar: =>
    

  renderFooter: =>

