class Fg2app.Views.LayoutListItemOptions extends Support.CompositeView

  template: FunJST('layouts/list_item_options')

  # events: 
  className: 'list-item-expander'

  initialize: (params)->
    super

  render: =>
    @renderBody()
    super

  renderBody: =>
    @$el.html @template( model: @model )
    @

