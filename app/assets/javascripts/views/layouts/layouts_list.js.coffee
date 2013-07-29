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
    @open_item  = null
    @collection.each (model)=>
      @appendChildTo @layoutView(model), list

    @bindTo @collection, 'expand', (params)=>
      @open_item && @open_item.trigger 'collapse'
      console.log 'params model', params.model
      console.log 'open item', @open_item
      @open_item = params.model
      # @open_item && @open_item.trigger 'expand'
      # @collapseItems(params.model) if params && params.model

    @

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
