# usage
# _.extend Fg2app.Collections.Layouts.prototype, Support.Mixin.Hammerable

Support.Mixin.Hammerable = 
  hammerify: ->
    @_hammer @hammer

  _hammer: (selectors)->
    if typeof selectors is 'undefined'
      return
    else if _.isArray selectors
      _.each selectors, @_hammer, @
    else if selectors is true
      @$el.hammer()
    else
      @$(selectors).hammer()
