class Fg2app.Views.LayoutsList extends Support.CompositeView

  template: JST['layouts/list']

  initialize: (options)->
    @collection = options.collection
    @bindTo @collection, "reset", (data)=>
      # alert @collection.length
      @renderList()
    @collection.fetch reset: true

  render: =>
    @renderBody().
      renderList()

  renderBody: =>
    @$el.html @template()
    @

  renderList: =>
    list  = @$(".layouts-list")
    list.empty()
    @collection.each (layout)=>
      @appendChildTo @layoutView(layout), list
    @

  layoutView: (layout)=>
    new Fg2app.Views.LayoutListItem model: layout