class Fg2app.Views.TopbarOption extends Support.CompositeView

  broker: Backbone.EventBroker.get('topbar')

  template: JST['components/topbar_option']

  events:
    'touch' : 'touch'

  hammer: true

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
    super

  isActive: false
  setOption: (option_name=null)=>
    @isActive = option_name == @action
    @$el.toggleClass 'active', @isActive

  touch:  =>
    @broker.trigger 'setOption', @action unless @isActive
