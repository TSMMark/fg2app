class Fg2app.Views.TopbarOption extends Support.CompositeView

  broker: Backbone.EventBroker.get('topbar')

  option_broker: null

  template: JST['components/topbar_option']

  events:
    'touch' : 'touch'

  hammer: true

  initialize: (params)->
    super
    @action   = params.action
    @label    = params.label
    @icon     = params.icon
    @is_tab   = params.is_tab
    @listenTo @broker, 'setOption', @setOption

    @option_broker = Backbone.EventBroker.get "topbar.#{@action}"
    @buttonize broker: @option_broker

  render: =>
    @$el.attr 'class',  "navbar-option-#{@action}"
    @$el.data 'action', "#{@action}"
    @$el.html @template(view: @)
    super

  isActive: false
  setOption: (option_name=null)=>
    was_active  = @isActive
    @isActive = option_name == @action
    return if @isActive is was_active
    @$el.toggleClass 'active', @isActive if @is_tab
    @option_broker.trigger 'click', action: option_name if @isActive

  touch:  =>
    @broker.trigger 'setOption', @action unless @isActive


_.extend Fg2app.Views.TopbarOption.prototype, Support.Mixin.Buttonable
