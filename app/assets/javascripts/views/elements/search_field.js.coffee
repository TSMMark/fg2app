class Fg2app.Views.Elements.SearchField extends Support.CompositeView

  broker: null
  eventName: 'search'
  
  template: FunJST('elements/search_field')

  events:
    'focus input'   : 'change'
    'blur input'    : 'change'
    'keyup input'   : 'change'
    'mouseup input' : 'change'
  input: null
  last_val: ''

  initialize: (params)->
    super
    @className    = params.className
    @idAttribute  = params.idAttribute
    @placeholder  = params.placeholder

    @broker       = Backbone.EventBroker.broker params.broker
    @eventName    = params.eventName
      

  render:=>
    @$el.html @template(view: @)
    @input  = @$('input')
    @

  change:=>
    return if @last_val == (val = @input.val())
    @last_val = val
    @broker.trigger(@eventName, val) if @broker
