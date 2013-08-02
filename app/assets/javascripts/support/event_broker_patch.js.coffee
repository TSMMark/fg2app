window.Backbone.EventBroker.broker = (broker)->
  unless typeof broker is 'object'
    broker       = Backbone.EventBroker.get broker
  broker