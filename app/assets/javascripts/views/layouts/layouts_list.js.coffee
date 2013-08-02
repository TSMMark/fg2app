class Fg2app.Views.LayoutsList extends Support.CompositeView

  topbarBroker: Backbone.EventBroker.get('topbar')
  
  template: JST['layouts/list']

  initialize: (params)->
    super
    # @bindTo @collection, 'reset', @filter

    @baseCollection   = @collection
    @collection       = @baseCollection.filtered(true)

    @listenTo @topbarBroker, 'setOption', @filterBy

  filterBy: (criteria=null)=>
    fn = switch criteria
      when 'complete' then @filterComplete
      else @resetFilter
    fn()

  resetFilter:=>
    @filter @baseCollection.filtered(true)

  filterComplete: =>
    @filter @baseCollection.areComplete()

  filter: (new_collection)=>
    @collection.teardown()
    @collection = new_collection
    @renderList()

  render: =>
    @renderBody()
    #@renderList() # don't render list until we know the filter
    @

  renderBody: =>
    @$el.html @template()
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
