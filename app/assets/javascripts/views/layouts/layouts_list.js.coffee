class Fg2app.Views.LayoutsList extends Support.CompositeView

  filterBroker:   Backbone.EventBroker.get('topbar')
  layoutsBroker:  Backbone.EventBroker.get('layouts')
  
  template: JST['layouts/list']

  initialize: (params)->
    super

    @baseCollection     = @collection
    @collection         = @collection.filtered(true)
    @categoryCollection = @collection.filtered(true)

    @registerFilterEvents()

    @registerLayoutListEvents()


  ###
  ================================
                RENDER
  ================================
  ###
  render: =>
    @renderBody()
    @renderSearchBar()
    #@renderList() # don't render list until we know the filter
    super

  renderBody: =>
    @$el.html @template()
    @

  renderSearchBar: =>
    html = new Fg2app.Views.Elements.SearchField
      className:    'layouts-list-search'
      placeholder:  'Search'
      broker:       @layoutsBroker
      eventName:    'search'

    @renderChildAs html, @$('.searchbar-container')
    @

  renderList: =>
    list  = @$('.layouts-list')
    list.empty()
    @clearExpandedItem()

    @collection.each (model)=>
      @appendChildTo @layoutView(model), list

    @expanded false
    @

  layoutView: (model)=>
    view = new Fg2app.Views.LayoutListItem
      model       : model,
      collection  : @collection



  ###
  ================================
                FILTER
  ================================
  ###
  registerFilterEvents: =>
    @filterBroker.register
      'setOption' : 'filterBy'
      ,@

  filterBy: (criteria=null)=>
    @layoutsBroker.trigger 'search.reset'
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



  ###
  ================================
          Layout List Events
  ================================
  ###
  registerLayoutListEvents: =>
    @layoutsBroker.register
      'search'        : 'filterSearch'
      'collapseItem'  : 'collapseItem'
      'expandItem'    : 'expandItem'
      ,@

  expanded: (bool=true)=>
    @$el.toggleClass 'one-is-expanded', !!bool
  _expanded: =>
    @expanded !!@expanded_item

  clearExpandedItem: =>
    @expanded_item  = null

  expandItem: (params)=>

    if !params.item || params.item isnt @expanded_item
      @expanded_item = params.item
    else
      @clearExpandedItem()

    @_expanded()
    
  collapseItem: (params)=>
    if params.item is @expanded_item
      @clearExpandedItem()
      @_expanded()
