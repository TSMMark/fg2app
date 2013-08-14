# usage
# _.extend Fg2app.Collections.Layouts.prototype, Support.Mixin.Hammerable

Support.Mixin.Leaveable = 
  leaveablize: ->
    @bindings   = _ []

    @children   = _ []
    @siblings   = _ []
    @parent     = null

  leave: ->
    # super
    @unbind()
    @unbindFromAll()

    @stopListening()
    @remove()
    @_leaveChildren()
    @_removeFromParent()
    @

  # leave a list of Views
  #   if passed a string, list = @[string].
  #     and list will be emptied when complete
  leaveList: (list)->
    original_list = list
    list && switch typeof list
      when 'string'
        original_list = @[list]
        @leaveList original_list
        @[list] = _ []
      else
        list.map (item)->
          item.leave && item.leave()
    original_list

  registerTo: (broker, register)->
    broker = Backbone.EventBroker.broker broker
    _(register).each (callback, event)=>
      callback = switch typeof callback
        when 'function' then callback
        else @[callback]
      @listenTo broker, event, callback
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

  renderChild: (view, siblings=null)->
    view.siblings = _([]).extend siblings if typeof siblings is 'array'
    view.parent = @
    @children.push view
    view.render()
    @

  renderChildInto: (view, container, siblings=null)->
    @renderChild view, siblings
    $(container).empty().html view.el
    @
      
  renderChildAs: (view, container, siblings=null)->
    c = $(container)
    c.empty()
    view.setElement c
    @renderChild view, siblings
    @
      
  appendChild: (view, siblings=null)->
    @renderChild view, siblings
    $(@el).append view.el
    @

  appendChildTo: (view, container, siblings=null)->
    @renderChild view, siblings
    $(container).append view.el
    @

  prependChild: (view, siblings=null)->
    @renderChild view, siblings
    $(@el).prepend view.el
    @

  prependChildTo: (view, container, siblings=null)->
    @renderChild view, siblings
    $(container).prepend view.el
    @

  _leaveChildren: ->
    # return LOG @children
    # _.each @children.clone(), (view)->
    #   view.leave && view.leave()
    # @
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

