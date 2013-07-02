window.Browser   = 
  hideAddressBar: ->
    # Hide mobile browser's address bar
    # window.addEventListener("load", ->
    #   # $("body").css "padding-bottom", "1px"
    #   setTimeout((->
    #     $("html").css (
    #       "height": "115%"
    #       "overflow-y": "scroll"
    #     )
    #     window.scrollTo 0, 50
    #     alert $(window).scrollTop()
    #   ), 5)
    # )
    adjustHeight = ->
      html = document.documentElement
      size = window.innerHeight
      html.style.height = (size + size) + "px"
      window.setTimeout((->
        if (window.pageYOffset == 0)
          window.scrollTo(0, 0)
        html.style.height = window.innerHeight + "px"
        alert html.style.height
      ), 1)
    if (!window.navigator.standalone)
      document.addEventListener("DOMContentLoaded", adjustHeight, false)

  can: (property)->
    !!Modernizr[property]

  cant: (property)->
    !Browser.can(property)