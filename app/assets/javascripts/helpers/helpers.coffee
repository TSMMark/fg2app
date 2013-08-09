window.Navigate = (path, params={})->
  params.trigger = true unless params.trigger is false
  Backbone.history.navigate path, params