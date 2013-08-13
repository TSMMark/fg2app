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
    accordion = new Fg2app.Views.Elements.Accordion
      name: 'layout-info-accordion'
      groups:
        [{
          name: 'general-info'
          inner: 'eeenner'
          in: true
        },{
          name: 'analytics-info'
          inner: 'eeenner'
        },{
          name: 'third-info'
          inner: 'eeenner'
        }]
    @appendChild accordion
    @