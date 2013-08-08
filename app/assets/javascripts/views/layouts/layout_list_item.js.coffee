class Fg2app.Views.LayoutListItem extends Support.CompositeView

  template: FunJST('layouts/list_item')

  # idAttribute:  ""
  # tagName:      "li"
  className:    "layout-list-item-container"

  events: 
    'touch li, .overlay'   : 'touchItem'

  hammer: [ 'li', '.overlay' ]

  initialize: (params)->
    super
    # @model

  render: =>
    @onceAgain 'renderExpander'
    @unbindFromAll()
    @renderBody()
      .bindEvents()
    @renderOnChange @model
    # @onChange @model, 'renderBody'
    super

  renderBody: =>
    @$el.html @template( model: @model )
    @applyImage()
    @

  bindEvents: =>
    @bindTo @model, 'expand', @expandItem
    @bindTo @model, 'collapse', @collapseItem

  touchItem: =>
    @model.trigger 'expand', model: @model


  expandItem: =>
    @$el.addClass 'expanded'
    @doOnce 'renderExpander'

  collapseItem: =>
    @$el.removeClass 'expanded'


  renderExpander: =>
    view = new Fg2app.Views.LayoutListItemOptions
      model       : @model
    @appendChild view


  applyImage: =>
    @$('.list-item-thumb').css
      'background-image': "url(#{ @model.get('thumb') })"

