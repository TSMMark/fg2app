# usage
# _.extend Fg2app.Collections.Layouts.prototype, Support.Mixin.Hammerable

Support.Mixin.Buttonable = 
  button_broker: null

  buttonize: (params)->
    @button_broker = params.broker
    @listenTo @button_broker, 'click', @button_click

  unbuttonize: ->
    @stopListening()

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