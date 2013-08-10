Helper.define 'Extend', (cla, mix)->
  _.extend cla.prototype, mix

window.Navigate = (path, params={})->
  Navigator.navigate path, params
# window.history.back()

class window.NavigatorClass
  navigate: (path, params={})=>
    return if Backbone.history.fragment is path
    params.trigger  = true unless params.trigger is false
    Backbone.history.navigate path, params

  back: ->
    window.history.back();

  forward: ->
    window.history.forward();


window.Navigator = new NavigatorClass()

  # history:  []
  # _marker:   0

  # _navigate: (path, params={})=>
  #   LOG '_nav', @history, @_marker
  #   params.trigger  = true unless params.trigger is false
  #   Backbone.history.navigate path, params

  # navigate: (path, params={})=>
  #   @history.splice @_marker + 1
  #   @history.push path
  #   @_marker = @history.length - 1
  #   @_navigate path, params

  # back: (params={})=>
  #   @_navigate_to_marker(@_marker - 1, params)

  # forward: (params={})=>
  #   @_navigate_to_marker(@_marker + 1, params)

  # _navigate_to_marker: (marker, params={})=>
  #   min = 0
  #   max = @history.length - 1
  #   marker = Math.min marker, max
  #   marker = Math.max marker, min
  #   LOG @_marker, marker
  #   if marker isnt @_marker
  #     @_marker = marker
  #     @_navigate(@history[@_marker], params)



