class Fg2app.Views.Dashboard.Fullpage extends Support.CompositeView

  sidebarBroker: Backbone.EventBroker.get 'sidebar'

  templates: 
    body: JST['dash/dash']

  events:
    # 'mousedown .view-overlay' : 'closeSidebars'
    'touch .view-overlay'     : 'closeSidebars'

    # 'touchstart .view-overlay' : 'closeSidebars'

  initialize: ->
    # listeners
    @sidebarBroker.register 
      'left.toggle'   : 'toggleSidebarLeft'
      'right.toggle'  : 'toggleSidebarRight'
      ,@

  render: =>
    @renderBody()
    @renderMainContent()
    @renderSidebar()
    @renderTopbar()
    @

  renderBody: =>
    @$el.html @templates.body
    @$('.view-overlay').hammer()


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

  toggleSidebarLeft: =>
    @toggleSidebar('left')

  toggleSidebarRight: =>
    @toggleSidebar('right')

  sidebarInClass: (side)=>
    "sidebar-in-#{side}"

  closeSidebars: =>
    Fg2app.$body.removeClass(@sidebarInClass('left'))
                .removeClass(@sidebarInClass('right'))

  toggleSidebar: (side)=>
    # get opposite side name
    other_side  = switch side
      when 'right' then 'left'
      else 'right'

    # also close on press escape
    # TODO eventbroker this

    this_sidebar_class  = @sidebarInClass side
    other_sidebar_class = @sidebarInClass other_side

    # if the sidebar is already in
    this_sidebar_is_in  = Fg2app.$body.hasClass(this_sidebar_class)
    
    # remove opposite class
    Fg2app.$body.removeClass(other_sidebar_class)
                .toggleClass(this_sidebar_class, !this_sidebar_is_in)

    # if Browser.can("csstransitions") # we don't need this.. it'll just pop in instead of animate
    
    # we don't need this because it's being handled in CSS under body.sidebar-in & {}
    # $("#menu-#{side}").toggleClass('in', !this_sidebar_is_in)
    

