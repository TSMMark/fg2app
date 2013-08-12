# usage
# _.extend Fg2app.Collections.Layouts.prototype, Support.Mixin.Hammerable

Support.Mixin.Buttonable = 
  button_broker: null
  button_events: {}

  buttonize: (params)->
    @button_broker = params.broker
    @button_events.click = params.click_event || 'click'

    @listenTo @button_broker, @button_events.click, @button_click

  unbuttonize: ->
    @stopListening()
    @button_broker = null
    @button_events = null

  button_click: (params)->
    LOG 'click', params
    action = params.action.split '.'
    switch action.length
      when 2
        if action[0] == 'navigate'
          @_trigger_navigate action[1]

  _trigger_navigate: (path)->
    Navigate path


  # initialize: ->
  #   @_super('initialize')