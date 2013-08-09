class Support.SwappingRouter extends Backbone.Router
  swap: (newView, options={})->
    options.render_as_el = false unless options.render_as_el is false
    if(@currentView && @currentView.leave)
      @currentView.leave()
    @currentView = newView;

    Backbone.EventBroker.destroy()
    
    @$el.empty()
    if options.render_as_el is true
      @currentView.setElement @$el[0]
      @currentView.render()
    else
      @currentView.render()
      @$el.append @currentView.el