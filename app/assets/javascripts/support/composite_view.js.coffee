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
    @stopListening()
    @remove()
    @_leaveChildren()
    @_removeFromParent()
    @

  bindTo: (source, event, callback)->
    source.on event, callback, @
    @bindings.push(source: source, event: event, callback: callback)
    @

  unbindFromAll: ->
    @bindings.each (binding)->
      binding.source.off binding.event, binding.callback
    @bindings = _ []
    @

  renderChild: (view)->
    view.parent = @
    @children.push view
    view.render()
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


# # # # # SPECIFIC EVENTS # # # # #

  onChange: (source, method_name, callback=null)->
    @bindTo source, 'change', (e)=>
      @[method_name].apply()
      callback && callback(e)
    @

  # @render on source:change
  renderOnChange: (source, callback=null)->
    @onChange source, 'render', callback
    @


# # # # # DO STUFF ONCE # # # # #

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


_.extend Support.CompositeView.prototype, Support.Mixin.ScopedStorage
