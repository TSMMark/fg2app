class Fg2app.Views.LayoutsList extends Backbone.View

  initialize: (options)->
    @collection = options.collection

  render: ->
    @renderList()
    @

  renderList: =>
    @$el.empty()
    @collection.each (layout)->
      renderOne(layout)
    @

  renderOne: (layout)=>
    view = new Fg2app.Views.LayoutListItem(model: layout)
    @$el.append view.render().el
    @