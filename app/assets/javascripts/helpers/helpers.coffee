# add / remove body classes depending on the present sidebars
Helper.define 'establishSidebars', (sides, $el)->
  possible_sides = ['left', 'right']
  _.each possible_sides, (side)->
    c = "has-sidebar-#{side}"
    $el.toggleClass c, _.include(sides, side)


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

