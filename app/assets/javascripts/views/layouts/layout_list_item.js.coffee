class Fg2app.Views.LayoutListItem extends Support.CompositeView

  template: FunJST('layouts/list_item')

  layoutsListBroker: Backbone.EventBroker.get('layouts')

  # idAttribute:  ""
  # tagName:      "li"
  className:    "layout-list-item-container"

  events: 
    'click li, .overlay'  : 'touchItem'
    'swiperight'          : 'swipeRight'

  hammer: true
  # hammer: [true] #[ true, 'li', '.overlay' ]

  initialize: (params)->
    super
    # @model

  leave: =>
    @layoutsListBroker.trigger 'collapse', model: @model if @expanded
    super

  render: =>
    @onceAgain 'renderExpander'
    @unbindFromAll()
    @renderBody()
    @bindEvents()

    @renderOnChange @model

    # @onChange @model, 'renderBody'
    super

  renderBody: =>
    @$el.html @template( model: @model )
    @applyImage()
    @

  renderExpander: =>
    view = new Fg2app.Views.LayoutListItemOptions
      model       : @model
    @appendChild view

  bindEvents: =>
    @bindTo @model, 'expand', @expandItem
    @bindTo @model, 'collapse', @collapseItem

  touchItem: =>
    @model.trigger 'expand', model: @model


  expandItem: =>
    @expanded   = true
    @$el.addClass 'expanded'
    @doOnce 'renderExpander'

  collapseItem: =>
    @expanded   = false
    @$el.removeClass 'expanded'

  swipeRight: =>
    @leave() if !@parent.expanded_item || @parent.expanded_item == @model


  applyImage: =>
    @$('.list-item-thumb').css
      'background-image': "url(#{ @model.get('thumb') })"

