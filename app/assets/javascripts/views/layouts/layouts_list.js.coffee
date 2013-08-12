class Fg2app.Views.LayoutsList extends Support.CompositeView

  filterBroker:   Backbone.EventBroker.get('topbar')
  layoutsBroker:  Backbone.EventBroker.get('layouts')
  
  template: JST['layouts/list']

  events: 
    'click .btn-new-layout' : 'newLayout'

  hammer: '.btn-new-layout'

  initialize: (params)->
    super

    @baseCollection     = @collection
    @collection         = @collection.filtered(true)
    @categoryCollection = @collection.filtered(true)

    @registerFilterEvents()

    @registerLayoutListEvents()


  newLayout: =>
    Navigate 'layouts/new'
    @layoutsBroker.trigger 'new'

  ###
  ================================
                RENDER
  ================================
  ###
  render: =>
    @renderBody()
    @renderSearchBar()
    @renderButtons()
    #@renderList() # don't render list until we know the filter
    super

  renderBody: =>
    @$el.html @template()
    @

  renderButtons: =>
    container = @$ '.list-header'
    new_layout_button   = new Fg2app.Views.Components.Buttons.NewLayoutButton()

    @appendChildTo new_layout_button, container

  renderSearchBar: =>
    html = new Fg2app.Views.Elements.SearchField
      className:    'layouts-list-search'
      placeholder:  'Search'
      broker:       @layoutsBroker
      eventName:    'search'

    @renderChildAs html, @$('.searchbar-container')
    @

  clearLayoutsList: =>
    @leaveList 'layouts_list'

  renderList: =>
    @clearLayoutsList()
    list  = @$('.layouts-list')
    list.empty()
    @clearExpandedItem()
    @_expanded()

    @collection.each (model)=>
      view = @layoutView(model)
      @layouts_list.push view
      @appendChildTo view, list

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
    @registerTo @filterBroker,
      'setOption' : 'filterBy'

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
    @registerTo @layoutsBroker,
      'search'        : 'filterSearch'
      'collapseItem'  : 'collapseItem'
      'expandItem'    : 'expandItem'

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
