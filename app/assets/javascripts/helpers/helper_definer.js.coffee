window.jst_helpers  = {}
window.Helper = 
  define: ->
    [name, func, template] = [null, null, false]
    _(arguments).each (a)->
      switch typeof(a)
        when "string"               then name       = a
        when "boolean"              then template   = a
        when "function", "object"   then func       = a

    throw new Error("Reserved helper name") if name == "define"

    window.Helper[name]      = func;

    window.jst_helpers[name] = func if(template)
    func