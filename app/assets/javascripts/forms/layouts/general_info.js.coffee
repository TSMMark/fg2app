class Fg2app.Forms.Layouts.GeneralInfo extends Fg2app.Forms.FormClass
  
  keys:
    'enter': 'next'

  initialize: (params={})->
    params.model ||= new Fg2app.Models.Layout
    super params
    # @listenTo @model, 'change', @change

  render: =>
    super
    @

  next: =>
    LOG @commit(), @model
  # change: =>
  #   alert 'change'