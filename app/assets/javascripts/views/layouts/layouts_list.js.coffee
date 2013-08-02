class Fg2app.Views.LayoutsList extends Support.CompositeView

  topbarBroker: Backbone.EventBroker.get('topbar')
  broker:       Backbone.EventBroker.get('layouts')
  
  template: JST['layouts/list']

  initialize: (params)->
    super
    # @bindTo @collection, 'reset', @filter

    @baseCollection     = @collection
    @collection         = @collection.filtered(true)
    @categoryCollection = @collection.filtered(true)

    @topbarBroker.register
      'setOption' : 'filterBy'
      ,@
    @broker.register
      'search'    : 'filterSearch'
      ,@

  filterBy: (criteria=null)=>
    @broker.trigger 'search.reset'
    fn = switch criteria
      when 'active'   then @filterActive
      when 'expired'  then @filterExpired
      when 'complete' then @filterComplete
      when 'archived' then @filterArchived
      else @resetFilter
    fn()

  resetFilter:=>
    @filter @baseCollection.filtered(true), true

  filterActive: =>
    @filter @baseCollection.areActive(), true

  filterExpired: =>
    @filter @baseCollection.areExpired(), true

  filterComplete: =>
    @filter @baseCollection.areComplete(), true

  filterArchived: =>
    @filter @baseCollection.areArchived(), true

  filterSearch: (terms)=>
    @filter @categoryCollection.search(terms), false

  # new_collection is the filtered collection to render
  # if is_category is false, it won't overwrite the Category Collection
  filter: (new_collection, is_category=true)=>
    @collection.teardown()
    @collection         = new_collection
    @categoryCollection = new_collection if is_category
    @renderList()

  render: =>
    @renderBody()
    @renderSearchBar()
    #@renderList() # don't render list until we know the filter
    @

  renderBody: =>
    @$el.html @template()
    @

  renderSearchBar: =>
    html = new Fg2app.Views.Elements.SearchField
      className:    'layouts-list-search'
      placeholder:  'Search'
      broker:       @broker
      eventName:    'search'

    @renderChildAs html, @$('.searchbar-container')
    @

  renderList: =>
    list  = @$('.layouts-list')
    list.empty()
    @expanded_item  = null

    @collection.each (model)=>
      @appendChildTo @layoutView(model), list

    # when one model expands, collapse the previously expanded one
    @bindTo @collection, 'expand', @expandOneItem
    
    @expanded false
    @

  expanded: (bool=true)=>
    @$el.toggleClass 'one-is-expanded', !!bool

  expandOneItem: (params={})=>
    console.log 'expandOneItem'
    # collapse the currently expanded model
    @expanded_item && @expanded_item.trigger 'collapse'

    # if we're not clicking the one that's already expanded
    if params.model isnt @expanded_item
      # store the currently expanded model
      @expanded_item = params.model
    else
      # there is no expanded_item
      @expanded_item = null

    @expanded !!@expanded_item

  layoutView: (model)=>
    view = new Fg2app.Views.LayoutListItem
      model       : model,
      collection  : @collection
