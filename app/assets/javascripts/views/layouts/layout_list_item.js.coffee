class Fg2app.Views.LayoutListItem extends Support.CompositeView

  layoutsBroker: Backbone.EventBroker.get('layouts')

  template: FunJST('layouts/list_item')

  className:    "layout-list-item-container"

  events: 
    'click li, .overlay'  : 'touchItem'
    'swiperight li'          : 'swipeRight'

  hammer: 'li'

  initialize: (params)->
    super
    @registerLayoutListEvents()


  ###
  ================================
                RENDER
  ================================
  ###
  render: =>
    @onceAgain 'renderExpander'
    @unbindFromAll()
    @renderBody()

    @renderOnChange @model

    super

  renderBody: =>
    @$el.html @template( model: @model )
    @applyImage()
    @

  renderExpander: =>
    view = new Fg2app.Views.LayoutListItemOptions
      model       : @model
    @appendChild view

  applyImage: =>
    @$('.list-item-thumb').css
      'background-image': "url(#{ @model.get('thumb') })"



  ###
  ================================
          Layout List Events
  ================================
  ###
  registerLayoutListEvents: =>
    @registerTo @layoutsBroker,
      'collapseItem'  : 'collapseItem'
      'expandItem'    : 'expandItem'

  touchItem: =>
    @layoutsBroker.trigger 'expandItem', item: @

  expandItem: (params)=>
    @registers
    LOG 'expand', params
    if !@expanded && params.item == @
      @expand()
    else
      @collapse()

  collapseItem: (params)=>
    @collapse() if params.item == @

  expand: =>
    @expanded   = true
    @$el.addClass 'expanded'
    @doOnce 'renderExpander'

  collapse: =>
    @expanded   = false
    @$el.removeClass 'expanded'

  swipeRight: =>
    @leave()

  leave: =>
    @layoutsBroker.trigger 'collapseItem', item: @
    super


