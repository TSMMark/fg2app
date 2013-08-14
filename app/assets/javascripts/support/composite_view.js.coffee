class Support.CompositeView extends Backbone.View


  constructor: (params)->
    @bindings   = _ []

    @children   = _ []
    @siblings   = _ []
    @parent     = null
    super params

  initialize: (params)->
    super params
    if params
      @model      = params.model        if params.model       isnt undefined
      @view       = params.view         if params.view        isnt undefined
      @collection = params.collection   if params.collection  isnt undefined

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
  leaveList: (list)=>
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

  render: =>
    super
    @hammerify()
    @

  registerTo: (broker, register)->
    broker = Backbone.EventBroker.broker broker
    _(register).each (callback, event)=>
      callback = switch typeof callback
        when 'function' then callback
        else @[callback]
      @listenTo broker, event, callback
    @

  bindTo: (source, event, callback)=>
    source.on event, callback, @
    @bindings.push(source: source, event: event, callback: callback)
    @

  unbindFromAll: =>
    @bindings.each (binding)->
      binding.source.off binding.event, binding.callback
    @bindings = _ []
    @

  renderChild: (view, siblings=null)=>
    view.siblings = _([]).extend siblings if typeof siblings is 'array'
    view.parent = @
    @children.push view
    view.render()
    @

  renderChildInto: (view, container, siblings=null)=>
    @renderChild view, siblings
    $(container).empty().append view.el
    @
      
  renderChildAs: (view, container, siblings=null)=>
    c = $(container)
    c.empty()
    view.setElement c
    @renderChild view, siblings
    @
      
  appendChild: (view, siblings=null)=>
    @renderChild view, siblings
    $(@el).append view.el
    @

  appendChildTo: (view, container, siblings=null)=>
    @renderChild view, siblings
    $(container).append view.el
    @

  prependChild: (view, siblings=null)=>
    @renderChild view, siblings
    $(@el).prepend view.el
    @

  prependChildTo: (view, container, siblings=null)=>
    @renderChild view, siblings
    $(container).prepend view.el
    @

  _leaveChildren: =>
    # return LOG @children
    # _.each @children.clone(), (view)->
    #   view.leave && view.leave()
    # @
    @children.chain().clone().each (view)->
      view.leave && view.leave()
    @

  _removeFromParent: =>
    @parent && @parent._removeChild(this)
    @

  _removeChild: (view)=>
    index = @children.indexOf view
    @children.splice index, 1
    @


# # # # # SPECIFIC EVENTS # # # # #

  onChange: (source, method_name, callback=null)=>
    @bindTo source, 'change', (e)=>
      @[method_name].apply()
      callback && callback(e)
    @

  # @render on source:change
  renderOnChange: (source, callback=null)=>
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
_.extend Support.CompositeView.prototype, Support.Mixin.Hammerable

# _.extend Support.CompositeView.prototype, Support.Mixin.Brokerable

