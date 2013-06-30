class Support.CompositeView extends Backbone.View
  
  children: _ []
  bindings: _ []

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

  unbindFromAll: ->
    @bindings.each (binding)->
      binding.source.unbind(binding.event, binding.callback)
    @bindings = _([])
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
      
  appendChild: (view)->
    @renderChild view
    $(@el).append view.el
    @

  appendChildTo: (view, container)->
    @renderChild view
    $(container).append view.el
    @

  appendChild: (view)->
    @renderChild view
    $(@el).prepend view.el
    @

  appendChildTo: (view, container)->
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

    