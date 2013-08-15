# usage
# _.extend Fg2app.Collections.Layouts.prototype, Support.Mixin.Brokerable

Support.Mixin.Brokerable = 
  # register to EventBroker with listenTo so
  #   they get cleaned up with stopListening
  # broker is the namespace of an event broker or an EventBroker itself
  # register is an Array of objects:
  #   {'eventname': 'function_name'}
  #   {'event':     @an_actual_function}
  registerTo: (broker, register)->
    broker = Backbone.EventBroker.broker broker
    _(register).each (callback, event)=>
      callback = switch typeof callback
        when 'function' then callback
        else @[callback]
      @listenTo broker, event, callback
    @