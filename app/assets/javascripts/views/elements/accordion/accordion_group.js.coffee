class Fg2app.Views.Elements.AccordionGroup extends Support.CompositeView

  broker: null
  
  template: FunJST('elements/accordion/group')

  className: 'accordion-group'

  initialize: (params={})->
    @in         = params.in
    @header     = params.header ||= 'acchead'
    @inner      = params.inner  ||= 'inner'
    @accordion  = params.accordion
    @name       = params.name
    super params

  render: =>
    @$el.html @template(view: @)
    super
