class Support.CompositeView extends Backbone.View


  constructor: (params)->
    @leaveablize()
    super params

  initialize: (params)->
    super params
    if params
      @model      = params.model        if params.model       isnt undefined
      @view       = params.view         if params.view        isnt undefined
      @collection = params.collection   if params.collection  isnt undefined

  render: =>
    super
    @hammerify()
    @

# # # # # SPECIFIC EVENTS # # # # #

  onChange: (source, method_name, callback=null)=>
    @bindOnto source, 'change', (e)=>
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
_.extend Support.CompositeView.prototype, Support.Mixin.Leaveable
_.extend Support.CompositeView.prototype, Support.Mixin.Brokerable

# _.extend Support.CompositeView.prototype, Support.Mixin.Brokerable

