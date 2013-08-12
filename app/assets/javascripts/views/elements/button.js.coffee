class Fg2app.Views.Elements.Button extends Support.CompositeView

  broker: null
  template: FunJST('elements/button')

  events:
    'touch'   : 'button_touch'

  initialize: (params={})->
    super params
    @className    = params.className
    @idAttribute  = params.idAttribute
    @placeholder  = params.placeholder
    @template     = FunJST params.template if params.template

    @icon_left    = params.icon_left
    @icon_right   = params.icon_right
    @button_text  = params.button_text

    @buttonize params.buttonize if params.buttonize

  render: =>
    @$el.html @template(view: @)
    @input  = @$('input')
    super

  button_touch: =>
    # alert 'touch'

_.extend Fg2app.Views.Elements.Button.prototype, Support.Mixin.Buttonable
