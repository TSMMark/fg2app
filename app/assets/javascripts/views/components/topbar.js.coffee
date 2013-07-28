class Fg2app.Views.Topbar extends Support.CompositeView

  template: JST['components/topbar']

  events: 
    'click .btn.btn-navbar[data-target]': 'clickExpandSidebar'

  initialize: (params)->
    @route = params.route
    @topbar_options = 
    switch @route
      when 'dash'
        [{
          action: 'active'
          icon: 'time'
          label: 'Active'
        },{
          action: 'expired'
          icon: 'exclamation-sign'
          label: 'Expired'
        },{
          action: 'complete'
          icon: 'ok'
          label: 'Complete'
        },{
          action: 'tags'
          icon: 'cloud'
          label: 'Tags'
        },{
          action: 'archive'
          icon: 'inbox'
          label: 'Archive'
        }]

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
