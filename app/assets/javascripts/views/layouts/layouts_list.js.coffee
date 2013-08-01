class Fg2app.Views.LayoutsList extends Support.CompositeView

  template: JST['layouts/list']

  initialize: (params)->
    # @collection
    @bindTo @collection, 'reset', (data)=>
      @renderList()
    @collection.fetch reset: true

  render: =>
    @renderBody().
      renderList()
    @

  renderBody: =>
    @$el.html @template()
    @

  renderList: =>
    list  = @$('.layouts-list')
    list.empty()
    @expanded_item  = null
    # @collection = @collection.areComplete() if @collection.length
    @collection.each (model)=>
      @appendChildTo @layoutView(model), list

    # when one model expands, collapse the previously expanded one
    @bindTo @collection, 'expand', @expandOneItem
    @

  expandOneItem: (params={})=>
    # collapse the currently expanded model
    @expanded_item && @expanded_item.trigger 'collapse'
    if params.model isnt @expanded_item
      # store the currently expanded model
      @expanded_item = params.model
    else
      # if we just collapsed the one we had expanded, there is no expanded_item
      @expanded_item = null
      # @collection = @collection.areComplete()
      # @render()

    @$el.toggleClass 'one-is-expanded', !!@expanded_item

  layoutView: (model)=>
    view = new Fg2app.Views.LayoutListItem
      model       : model,
      collection  : @collection

  # collapseItems: (except=null)=>
  #   @collection.each (model)=>
  #     if model is except
  #       model.trigger 'expand'
  #     else 
  #       model.trigger 'collapse'
