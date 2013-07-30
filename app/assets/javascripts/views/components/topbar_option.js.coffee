class Fg2app.Views.TopbarOption extends Support.CompositeView

  template: JST['components/topbar_option']

  # events:

  initialize: (params)->
    @action = params.action
    @label  = params.label
    @icon   = params.icon

  render:->
    @$el.attr 'class',  "navbar-option-#{@action}"
    @$el.data 'action', "#{@action}"
    @$el.html @template(view: @)