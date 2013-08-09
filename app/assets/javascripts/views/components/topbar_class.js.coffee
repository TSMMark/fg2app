class Fg2app.Views.Topbar extends Support.CompositeView

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

  initialize: (params={})->
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
