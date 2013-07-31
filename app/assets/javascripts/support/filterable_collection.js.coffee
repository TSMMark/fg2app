# usage
# _.extend Fg2app.Collections.Layouts.prototype, Support.FilterableCollectionMixin

Support.FilterableCollectionMixin = 
  filtered: (criteria=true) ->
    criteria = (-> criteria) if typeof criteria isnt 'function'
    sourceCollection = this
    filteredCollection = new @constructor

    addToFiltered = (model, collection) ->
      filteredCollection.add model, collection  if criteria(model)

    removeFromFiltered = (model, collection) ->
      filteredCollection.remove model, collection

    changeFiltered = (model, collection) ->
      if criteria(model)
        if filteredCollection.contains(model)
          filteredCollection.trigger "change", model
        else
          addToFiltered model, collection
      else
        removeFromFiltered model, collection

    @bind "change", changeFiltered
    @bind "add", addToFiltered
    @bind "remove", removeFromFiltered

    filteredCollection.teardown = ->
      sourceCollection.unbind "change", changeFiltered
      sourceCollection.unbind "add", addToFiltered
      sourceCollection.unbind "remove", removeFromFiltered

    filteredCollection.refilter = (newCriteria) ->
      
      # TODO: It would be more efficient to iterate
      # over sourceCollection and selectively add or remove
      criteria = newCriteria
      filteredCollection.reset sourceCollection.select(criteria)

    filteredCollection.reset sourceCollection.select(criteria)
    filteredCollection