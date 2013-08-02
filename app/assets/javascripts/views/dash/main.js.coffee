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
    # BOOTSTRAPPED
    layouts     = Bootstrapper.get 'layouts'
    collection  = new Fg2app.Collections.Layouts layouts

    view        = new Fg2app.Views.LayoutsList collection: collection

    container   = @$(".layouts-list-container")
    @renderChildAs view, container
    @