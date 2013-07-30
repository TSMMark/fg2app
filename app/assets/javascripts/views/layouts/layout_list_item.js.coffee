class Fg2app.Views.LayoutListItem extends Support.CompositeView

  template: FunJST('layouts/list_item')

  # idAttribute:  ""
  # tagName:      "li"
  className:    "layout-list-item-container"

  events: 
    'click li, .overlay'   : 'clickItem'

  initialize: (params)->
    # @model

  render: =>
    @onceAgain 'renderExpander'
    @unbindFromAll()
    @renderBody()
      .bindEvents()
    @renderOnChange @model
    # @onChange @model, 'renderBody'
    @

  renderBody: =>
    @$el.html @template( model: @model )
    @

  bindEvents: =>
    @bindTo @model, 'expand', @expandItem
    @bindTo @model, 'collapse', @collapseItem

  clickItem: =>
    @model.trigger 'expand', model: @model


  expandItem: =>
    @$el.addClass 'expanded'
    # @model.set 'name', 'expand'
    @doOnce 'renderExpander'
    # @renderExpander()

  collapseItem: =>
    @$el.removeClass 'expanded'
    # @model.set 'name', 'collapse'


  renderExpander: =>
    view = new Fg2app.Views.LayoutListItemOptions
      model       : @model
    @appendChild view #, @$('.list-item-expander')



