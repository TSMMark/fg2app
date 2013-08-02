class Support.FilterableView extends Support.CompositeView
  
  events:
    'reset'   : 'onReset'

  initialize  : (params)->
    super
    @baseCollection   = @collection
    @collection       = @baseCollection.filtered (-> false)

  onReset     : =>
    console.log 'reset'
    
  applyFilter : =>
    # filterFunction  = @computeFilterFunction()
    filterFunction    = (-> true)
    # filtering logic
    @filteredFunction.teardown()
    @collection       = @baseCollection.filtered filterFunction
