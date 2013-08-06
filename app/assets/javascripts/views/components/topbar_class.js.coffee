class Fg2app.Views.Topbar extends Support.CompositeView

  broker: Backbone.EventBroker.get('topbar')
  template: JST['components/topbar']

  events: 
    'click .btn.btn-navbar-left':   'expandSidebarLeft'
    'click .btn.btn-navbar-right':  'expandSidebarRight'

  topbar_options: {}

  initialize: (params)->
    super
    @listenTo @broker, 'setOption', @setCurrentOption
    
    if typeof params.topbar_options is 'object'
      @topbar_options = _.extend @topbar_options, params.topbar_options

  setCurrentOption: (name)->
    @stave 'current_option', name
    Global.set 'topbar_option', name
    @

  render:->
    @renderBody()
    @renderOptions()

    current_option = @stave('current_option') || @default_option
    @broker.trigger 'setOption', current_option
    @

  renderBody: ->
    @$el.html @template(view: @)
    @

  renderOptions:->
    container = @$('.navbar-options').empty()
    _.each @topbar_options, (option)=>
      pane  = new Fg2app.Views.TopbarOption(option)
      @appendChildTo pane, container
    @


  toggleSidebar: (e,side)->
    e.preventDefault()
    e.stopImmediatePropagation()

    other_side          = side is "right" ? "left" : "right"

    # also close on press escape
    # TODO eventbroker this
    this_sidebar_class  = "sidebar-in-#{side}"
    other_sidebar_class = "sidebar-in-#{other_side}"

    this_sidebar_is_in  = Fg2app.$body.hasClass(this_sidebar_class)
    
    # other_sidebar_is_in = Fg2app.$body.hasClass(other_sidebar_class)

    Fg2app.$body.removeClass(other_sidebar_class)
    Fg2app.$body.toggleClass(this_sidebar_class, !this_sidebar_is_in)

    # if Browser.can("csstransitions")
    # use CSS3 Transitions instead
    $("#menu-#{side}").toggleClass('in', !this_sidebar_is_in)
    
    # otherwise let Bootstrap handle it using jQuery animation


  # events
  expandSidebarLeft: (e)->
    @toggleSidebar e,'left'

  expandSidebarRight: (e)->
    @toggleSidebar e,'right'
