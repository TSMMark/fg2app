class Fg2app.Forms.Layouts.GeneralInfo extends Fg2app.Forms.FormClass
  
  initialize: (params={})->
    params.model ||= new Fg2app.Models.Layout
    super params

  render: =>
    super
    @