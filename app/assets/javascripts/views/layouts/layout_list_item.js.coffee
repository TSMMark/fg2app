class Fg2app.Views.LayoutListItem extends Support.CompositeView

  template: FunJST('layouts/list_item')

  tagName:      "li"
  # idAttribute:  ""
  className:    "layout-list-item"

  events: 
    'click'   : 'clickItem'

  initialize: (params)->
    # @model
    @renderOnChange @model

  render: =>
    @unbindFromAll()
    @renderBody()
      .bindEvents()

  renderBody: =>
    @$el.html @template( model: @model )
    @

  bindEvents: =>
    console.log "binding events on #{@model.id}"
    @bindTo @model, 'expand', @expandItem
    @bindTo @model, 'collapse', @collapseItem

  clickItem: =>
    console.log 'click event'
    @model.trigger 'expand', model: @model
    # @expandItem()


  expandItem: =>
    @$el.addClass 'expanded'
    @model.set 'name', 'expand'
    console.log 'expand! parent: ', @parent

  collapseItem: =>
    @model.set 'name', 'collapse'
    console.log 'collapse!'

