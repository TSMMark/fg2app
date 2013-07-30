class Fg2app.Views.LayoutListItem extends Support.CompositeView

  template: FunJST('layouts/list_item')

  tagName:      "li"
  # idAttribute:  ""
  className:    "layout-list-item"

  events: 
    'click'   : 'clickItem'

  initialize: (params)->
    # @model

  render: =>
    @unbindFromAll()
    @renderBody()
      .bindEvents()
    @renderOnChange @model
    @

  renderBody: =>
    @$el.html @template( model: @model )
    @

  bindEvents: =>
    @bindTo @model, 'expand', @expandItem
    @bindTo @model, 'collapse', @collapseItem

  clickItem: =>
    @model.trigger 'expand', model: @model
    # @expandItem()


  expandItem: =>
    @$el.addClass 'expanded'
    @model.set 'name', 'expand'

  collapseItem: =>
    @$el.removeClass 'expanded'
    @model.set 'name', 'collapse'

