# usage
# _.extend Fg2app.Collections.Layouts.prototype, Support.Mixin.ScopedStorage

Support.Mixin.ScopedStorage = 
  _name_of_class: ->
    @constructor.name

  stave: (name, value)->
    name = "#{@_name_of_class()}-#{name}"
    Stave(name, value)