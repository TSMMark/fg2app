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
          header: 'General Info'
          name: 'general-info'
          inner: generalInfoForm
          in: true
        },{
          header: 'Analytics'
          name: 'analytics-info'
          inner: 'inner<br/>inner<br/>inner<br/>inner<br/>inner<br/>'
        },{
          header: 'Third Category'
          name: 'third-info'
          inner: 'inner<br/>inner<br/>inner<br/>inner<br/>inner<br/>inner<br/>inner<br/>'
        }]
    @appendChild accordion
    @