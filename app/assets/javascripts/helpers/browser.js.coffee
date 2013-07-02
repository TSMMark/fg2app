window.Browser   = 
  hideAddressBar: ->
    # Hide mobile browser's address bar
    window.addEventListener("load", ->
      $("body").css "padding-bottom", "1px"
      setTimeout((->
        window.scrollTo 0, 1
        alert $(window).scrollTop()
      ), 350)
    )

  can: (property)->
    !!Modernizr[property]

  cant: (property)->
    !Browser.can(property)