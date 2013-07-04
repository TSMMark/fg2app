window.FunJST = (template)->
  (params)->
    params  ||= {}
    # params    = _.$extend(params, window.jst_helpers) if window.jst_helpers
    # delete params.define
    # console.log "FunJST params", params
    JST[template](params)