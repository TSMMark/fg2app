class Fg2app.Views.LayoutListItemOptions extends Support.CompositeView

  template: FunJST('layouts/list_item_options')

  # events: 
  #   'click li'   : 'clickItem'
  className: 'list-item-expander'

  initialize: (params)->
    # @model

  render: =>
    # @unbindFromAll()
    @renderBody()
      # .bindEvents()
    @

  renderBody: =>
    @$el.html @template( model: @model )
    @

