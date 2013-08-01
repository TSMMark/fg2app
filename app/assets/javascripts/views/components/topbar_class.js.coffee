class Fg2app.Views.Topbar extends Support.CompositeView

  template: JST['components/topbar']

  events: 
    'click .btn.btn-navbar[data-target]': 'clickExpandSidebar'

  topbar_options: {}

  initialize: (params)->
    if typeof params.topbar_options is 'object'
      @topbar_options = _.extend @topbar_options, params.topbar_options

  setCurrentOption: (name)->
    alert @_name_of_class()
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

  renderBody: ->
    @$el.html @template(view: @)

  renderOptions:->
    container = @$('.navbar-options').empty()
    _.each @topbar_options, (option)=>
      pane  = new Fg2app.Views.TopbarOption(option)
      @appendChildTo pane, container
    # make one active at random
    active_option = _.first _.shuffle(@topbar_options)
    @$(".navbar-option-#{active_option.action}").addClass('active')


  # events
  clickExpandSidebar: (e)->
    # also close on press escape
    $("body").toggleClass("sidebar-in")

    if Browser.can("csstransitions")
      # use CSS3 Transitions instead
      e.stopImmediatePropagation()
      $($(e.currentTarget).data('target')).toggleClass("in")
    
    # otherwise let Bootstrap handle it using jQuery animation
