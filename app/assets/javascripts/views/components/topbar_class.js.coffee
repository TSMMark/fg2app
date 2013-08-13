class Fg2app.Views.TopbarClass extends Support.CompositeView

  broker:         Backbone.EventBroker.get('topbar')
  sidebarBroker:  Backbone.EventBroker.get('sidebar')

  template: JST['components/topbar']

  events: 
    'touch .btn.btn-navbar-left':   'expandSidebarLeft'
    'touch .btn.btn-navbar-right':  'expandSidebarRight'

  hammer: [
    '.btn.btn-navbar-left'
    '.btn.btn-navbar-right'
  ]
  
  side_panels: [ 'left' , 'right' ]

  topbar_options: {}

  are_tabs: true

  initialize: (params={})->
    super
    @listenTo @broker, 'setOption', @setCurrentOption
    @are_tabs = false if params.are_tabs is false

    if typeof params.topbar_options is 'object'
      @topbar_options = _.extend @topbar_options, params.topbar_options

    _.each @topbar_options, (option)=>
      option.is_tab = @are_tabs if typeof option.is_tab isnt 'boolean'

  setCurrentOption: (name)->
    @stave 'current_option', name
    Global.set 'topbar_option', name
    @

  render:->
    @renderBody()
    @renderOptions()

    unless @default_option is null
      current_option = @stave('current_option') || @default_option
      @broker.trigger 'setOption', current_option
    super

  renderBody: ->
    @$el.html @template(view: @)
    @

  renderOptions:->
    container = @$('.navbar-options').empty()
    _.each @topbar_options, (option)=>
      pane  = new Fg2app.Views.TopbarOption(option)
      @appendChildTo pane, container
    @


  triggerSidebar: (e,side)=>
    e.preventDefault()
    e.stopImmediatePropagation()
    @sidebarBroker.trigger("#{side}.toggle")

  expandSidebarLeft: (e)->
    @triggerSidebar e, 'left'

  expandSidebarRight: (e)->
    @triggerSidebar e, 'right'
