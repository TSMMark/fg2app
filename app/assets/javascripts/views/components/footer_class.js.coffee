class Fg2app.Views.Footer extends Support.CompositeView

  broker:   Backbone.EventBroker.get('footer')

  template: JST['components/footer']

  events: {}

  initialize: (params={})->
    super

  render: ->
    @renderBody()
    super

  renderBody: ->
    @$el.html @template(view: @)
    @
    