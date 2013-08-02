class Fg2app.Views.Topbar extends Support.CompositeView

  broker: Backbone.EventBroker.get('topbar')
  template: JST['components/topbar']

  events: 
    'click .btn.btn-navbar[data-target]': 'clickExpandSidebar'

  topbar_options: {}

  initialize: (params)->
    super
    @listenTo @broker, 'setOption', @setCurrentOption
    
    if typeof params.topbar_options is 'object'
      @topbar_options = _.extend @topbar_options, params.topbar_options

  setCurrentOption: (name)->
    @stave 'current_option', name
    Global.set 'topbar_option', name
    # trigger event-broker event
    
    console.log '# # # # # setCurrentOption # # # # #'
    console.log "Global.get 'topbar_option'", Global.get 'topbar_option'
    console.log "@stave 'current_option'", @stave 'current_option'
    @

  render:->
    @renderBody()
    @renderOptions()

    current_option = @stave('current_option') || @default_option
    @broker.trigger 'setOption', current_option
    # @setCurrentOption current_option

  renderBody: ->
    @$el.html @template(view: @)

  renderOptions:->
    container = @$('.navbar-options').empty()
    _.each @topbar_options, (option)=>
      pane  = new Fg2app.Views.TopbarOption(option)
      @appendChildTo pane, container


  # events
  clickExpandSidebar: (e)->
    # also close on press escape
    $("body").toggleClass("sidebar-in")

    if Browser.can("csstransitions")
      # use CSS3 Transitions instead
      e.stopImmediatePropagation()
      $($(e.currentTarget).data('target')).toggleClass("in")
    
    # otherwise let Bootstrap handle it using jQuery animation
