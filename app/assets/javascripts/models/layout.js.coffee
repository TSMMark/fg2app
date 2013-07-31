class Fg2app.Models.Layout extends Backbone.Model
  # url:      '/api/v1/layouts'
  urlRoot:  '/api/v1/layouts'
  
  validate: ->

  isComplete: =>
    console.log 'isComplete?', @get('description')
    !!@get('description').match /description/