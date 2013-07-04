_.$extend = (obj1,obj2)->
  obj   = _(obj1).clone()
  for name, attr of obj2
    obj[name] = attr
  obj
