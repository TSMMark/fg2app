class Fg2app.Views.Elements.Accordion extends Support.CompositeView

  template: FunJST('elements/accordion/accordion')

  broker: null

  className:    'accordion'

  initialize: (params={})->
    params.attributes ||= {}
    # unless params.name
    #   name  = (Math.random() * 10).toFixed(8).split('.').join('')
    #   params.name = "accordion-#{name}"
    
    # params.attributes['id'] = params.name
    LOG 'params', params
    
    super params
    @groups   = params.groups

    _.each @groups, (group)=>
      group.accordion = params.attributes['id']

  render: =>
    @renderBody()
    .renderGroups()
    super

  renderBody: =>
    @$el.html @template(view: @)
    @

  renderGroups: =>
    @emptyGroups()
    _.each @groups, (group)=>
      @renderGroup group
    @

  renderGroup: (group)=>
    view = new Fg2app.Views.Elements.AccordionGroup group
    @appendChild view
    @

  emptyGroups: =>
    @$el.empty()
    @


