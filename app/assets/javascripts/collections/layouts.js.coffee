class Fg2app.Collections.Layouts extends Backbone.Collection
  url: '/api/v1/layouts'

  model: Fg2app.Models.Layout

  search: (terms)=>
    @filtered (model)->
      model.matchesTerms(terms)

  areActive: =>
    @filtered (model)->
      model.isActive()

  areExpired: =>
    @filtered (model)->
      model.isExpired()

  areComplete: =>
    @filtered (model)->
      model.isComplete()

  areArchived: =>
    @filtered (model)->
      model.isArchived()

  # filtered: (matcher=true)=>
  #   matcher = (-> matcher) if typeof matcher isnt 'function'
  #   new @constructor  @select(matcher)

_.extend Fg2app.Collections.Layouts.prototype, Support.Mixin.FilterableCollection