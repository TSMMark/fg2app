class Fg2app.Views.Topbar extends Support.CompositeView

  template: JST['components/topbar']

  events: 
    'click .btn.btn-navbar[data-target]': 'clickExpandSidebar'

  initialize: ->

  render:->
    @$el.html @template

  clickExpandSidebar: (e)->
    # also close on press escape
    $("body").toggleClass("sidebar-in")

    if Browser.can("csstransitions")
      # use CSS3 Transitions instead
      e.stopImmediatePropagation()
      $($(e.currentTarget).data('target')).toggleClass("in")
    
    # otherwise let Bootstrap handle it using jQuery animation