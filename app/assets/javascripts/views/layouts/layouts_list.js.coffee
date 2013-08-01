class Fg2app.Views.LayoutsList extends Support.CompositeView

  template: JST['layouts/list']

  initialize: (params)->
    # @bindTo @collection, 'reset', @filter

    @baseCollection   = @collection
    @collection       = @baseCollection.filtered(false)

    @listenTo Dispatch, 'nav.top.complete', @filterComplete

  filterComplete: (e=null)=>
    @filter @baseCollection.areComplete()

  filter: (new_collection)=>
    @collection.teardown()
    @collection = new_collection
    @renderList()

  render: =>
    @renderBody()
    #@renderList()
    @

  renderBody: =>
    @$el.html @template()
    @

  renderList: =>
    console.log 'renderList', @collection.length
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
      # @collection = @collection.areComplete()
      # @render()

    @expanded !!@expanded_item

  layoutView: (model)=>
    view = new Fg2app.Views.LayoutListItem
      model       : model,
      collection  : @collection
