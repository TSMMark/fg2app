class Fg2app.Views.Elements.AccordionGroup extends Support.CompositeView

  broker: null
  
  template: FunJST('elements/accordion/group')

  className: 'accordion-group'

  $elements:
    'accordion_inner': '.accordion-inner'

  initialize: (params={})->
    @in         = params.in
    @header     = params.header
    @inner      = params.inner
    @accordion  = params.accordion
    @name       = params.name
    @header_tag = 'h4'
    super params

  render: =>
    @renderBody()
    .findElements()
    .renderInner()
    super

  renderBody: =>
    @$el.html @template(view: @)
    @

  renderInner: =>
    if @inner
      if @inner.render
        @renderChildInto @inner, @$accordion_inner
      else
        @$accordion_inner.html @inner
    @

  findElements: (refresh=false)=>
    _.each @$elements, (selector, varname)=>
      varname     = "$#{varname}"
      @[varname]  = @$("#{selector}") if !@[varname] || refresh
    @


