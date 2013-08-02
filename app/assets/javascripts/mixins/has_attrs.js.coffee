# usage
# _.extend Fg2app.Collections.Layouts.prototype, Support.FilterableCollectionMixin

Support.Mixin.HasAttrs = 
  _attrs: {}

  get: (index)=>
    Bootstrapper._attrs[index]

  set: (index, value)=>
    Bootstrapper._attrs[index] = value

  