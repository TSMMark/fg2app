window.Global = 
  attrs: {}

  get: (index)=>
    Global.attrs[index]

  set: (index, value)=>
    Global.attrs[index] = value
