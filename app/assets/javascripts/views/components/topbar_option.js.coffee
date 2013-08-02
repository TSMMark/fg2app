class Fg2app.Views.TopbarOption extends Support.CompositeView

  broker: Backbone.EventBroker.get('topbar')

  template: JST['components/topbar_option']

  events:
    'click' : 'click'

  initialize: (params)->
    super
    @action = params.action
    @label  = params.label
    @icon   = params.icon
    @listenTo @broker, 'setOption', @setOption

  render: =>
    @$el.attr 'class',  "navbar-option-#{@action}"
    @$el.data 'action', "#{@action}"
    @$el.html @template(view: @)
    @

  setOption: (option_name=null)=>
    @$el.toggleClass 'active', option_name == @action

  click:  =>
    # Dispatch.trigger "nav.top.#{@action}"
    @broker.trigger 'setOption', @action