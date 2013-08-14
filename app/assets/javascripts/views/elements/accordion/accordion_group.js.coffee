class Fg2app.Views.Elements.AccordionGroup extends Support.CompositeView

  broker: null
  
  template: FunJST('elements/accordion/group')

  className: 'accordion-group'

  establish:
    'accordion_inner': '.accordion-inner'

  initialize: (params={})->
    @in         = params.in
    @header     = params.header ||= 'acchead'
    @inner      = params.inner
    @accordion  = params.accordion
    @name       = params.name
    super params

  render: =>
    @renderBody()
    .renderInner()
    super

  renderBody: =>
    @$el.html @template(view: @)
    @$establish()
    @

  renderInner: =>
    if @inner
      if @inner.render
        @renderChildInto @inner, @$accordion_inner
      else
        @$accordion_inner.html @inner
    @

  $establish: (refresh=false)=>
    _.each @establish, (selector, varname)=>
      varname     = "$#{varname}"
      @[varname]  = @$("#{selector}") if !@[varname] || refresh
    @


