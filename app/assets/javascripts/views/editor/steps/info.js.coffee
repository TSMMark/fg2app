class Fg2app.Views.Editor.InfoStep extends Support.CompositeView

  templates: 
    body: JST['editor/steps/info']

  initialize: ->
    super

  render: =>
    @renderBody()
    .renderForm()
    super

  renderBody: =>
    @$el.html @templates.body
    @

  renderForm: =>
    # view = new Fg2app.Views.Editor.InfoStep()
    @