class Support.CompositeView extends Backbone.View
  
  children: _ []
  bindings: _ []

  initialize: (params)->
    @model      = params.model        if params.model       isnt undefined
    @view       = params.view         if params.view        isnt undefined
    @collection = params.collection   if params.collection  isnt undefined

  leave: ->
    @unbind()
    @unbindFromAll()
    @remove()
    @_leaveChildren()
    @_removeFromParent()
    @

  bindTo: (source, event, callback)->
    source.bind event, callback, @
    @bindings.push(source: source, event: event, callback: callback)
    @

  renderOnChange: (source, callback=null)->
    @onChange source, 'render', callback
    @

  onChange: (source, method_name, callback=null)->
    @bindTo source, 'change', (e)=>
      @[method_name].apply()
      callback && callback(e)
    @

  unbindFromAll: ->
    @bindings.each (binding)->
      binding.source.unbind(binding.event, binding.callback)
    @bindings = _ []
    @

  renderChild: (view)->
    view.render()
    @children.push view
    view.parent = @
    @

  renderChildInto: (view, container)->
    @renderChild view
    $(container).empty().append view.el
    @
      
  renderChildAs: (view, container)->
    c = $(container)
    c.empty()
    view.setElement c
    @renderChild view
    @
      
  appendChild: (view)->
    @renderChild view
    $(@el).append view.el
    @

  appendChildTo: (view, container)->
    @renderChild view
    $(container).append view.el
    @

  prependChild: (view)->
    @renderChild view
    $(@el).prepend view.el
    @

  prependChildTo: (view, container)->
    @renderChild view
    $(container).prepend view.el
    @

  _leaveChildren: ->
    @children.chain().clone().each (view)->
      view.leave && view.leave()
    @

  _removeFromParent: ->
    @parent && @parent._removeChild(this)
    @

  _removeChild: (view)->
    index = @children.indexOf view
    @children.splice index, 1
    @


  # set once to bool and return old value
  onceSet: (method_name, bool=true)=>
    @onces    ||= {}
    p           = "_#{method_name}_is_done"
    former      = @onces[p]
    @onces[p]   = bool
    former

  # perform an action on self only if the action hasn't been already performed
  doOnce: (method_name, params=null)=>
    # return if it's already been done
    return undefined if @onceSet(method_name, true)
    # call method
    if typeof params is 'array'
      @[method_name].apply(@, params)
    else
      @[method_name](params)

  onceAgain: (method_name)=>
    @onceSet(method_name, false)
