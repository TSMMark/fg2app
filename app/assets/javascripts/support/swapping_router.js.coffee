class Support.SwappingRouter extends Backbone.Router
  swap: (newView)->
    if(@currentView && @currentView.leave)
      @currentView.leave()
    @currentView = newView;
    @$el.empty().append @currentView.render().el