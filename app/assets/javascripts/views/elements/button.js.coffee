class Fg2app.Views.Elements.SearchField extends Support.CompositeView

  broker: null
  template: FunJST('elements/button')

  events:
    'touch'   : 'touch'

  initialize: (params)->
    super params
    @className    = params.className
    @idAttribute  = params.idAttribute
    @placeholder  = params.placeholder

    # @broker       = Backbone.EventBroker.broker params.broker
    # @eventName    = params.eventName
    

  render:=>
    @$el.html @template(view: @)
    @input  = @$('input')
    super

  touch: =>
    alert 'touch'