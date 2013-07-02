window.Browser   = 
  hideAddressBar: ->
    # Hide mobile browser's address bar
    setTimeout((->
      $("body").css "padding-bottom", "1px"
      window.scrollTo 0, 1
      alert $(window).scrollTop()
    ), 350)

  can: (property)->
    !!Modernizr[property]

  cant: (property)->
    !Browser.can(property)