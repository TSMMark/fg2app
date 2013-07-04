class Fg2app.Views.Dashboard.Main extends Support.CompositeView

  template: JST['dash/main']
  id: 'main-content'

  initialize: ->
    # listeners

  render: =>
    @renderBody()
    @renderLayouts()
    @

  renderBody: =>
    @$el.html @template
    @

  renderLayouts: =>
    collection = new Fg2app.Collections.Layouts()
    view  = new Fg2app.Views.LayoutsList collection: collection

    container = @$(".layouts-list-container")
    @renderChildAs view, container