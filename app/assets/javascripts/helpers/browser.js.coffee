window.Browser   = 
  hideAddressBar: ->
    # Hide mobile browser's address bar
    setTimeout((-> window.scrollTo(0, 1)), 1)

  can: (property)->
    !!Modernizr[property]

  cant: (property)->
    !Browser.can(property)