class Fg2app.Views.LayoutListItem extends Support.CompositeView

  template: JST['layouts/list_item']

  tagName:      "li"
  # idAttribute:  ""
  className:    "layout-list-item"

  initialize: (options)->
    @model = options.model

  render: =>
    @$el.html @template()
    @
