class Fg2app.Forms.Layouts.GeneralInfo extends Backbone.Form
  
  initialize: (params={})->
    params.model ||= new Fg2app.Models.Layout
    super params

  render: =>
    super
    @