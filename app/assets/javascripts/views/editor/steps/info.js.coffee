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
    generalInfoForm = new Fg2app.Forms.Layouts.GeneralInfo
    accordion = new Fg2app.Views.Elements.Accordion
      attributes:
        id: 'layout-info-accordion'
      groups:
        [{
          name: 'general-info'
          inner: generalInfoForm.render().el
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