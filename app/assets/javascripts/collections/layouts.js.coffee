class Fg2app.Collections.Layouts extends Backbone.Collection
  url: '/api/v1/layouts'

  model: Fg2app.Models.Layout

  areComplete: =>
    @filtered (model)->
      model.isComplete()

  # filtered: (matcher=true)=>
  #   matcher = (-> matcher) if typeof matcher isnt 'function'
  #   new @constructor  @select(matcher)

_.extend Fg2app.Collections.Layouts.prototype, Support.Mixin.FilterableCollection