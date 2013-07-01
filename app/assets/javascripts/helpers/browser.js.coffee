window.Browser   = 

  can: (property)->
    !!Modernizr[property]

  cant: (property)->
    !Browser.can(property)