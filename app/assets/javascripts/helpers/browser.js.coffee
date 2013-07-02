window.Browser   = 
  hideAddressBar: ->
    adjustHeight = ->
      html = document.documentElement
      size = window.innerHeight
      html.style.height = (size + size) + "px"
      window.setTimeout((->
        if (window.pageYOffset == 0)
          window.scrollTo(0, 0)
        html.style.height = window.innerHeight + "px"
      ), 1)
    if(Browser.appleStandalone == false)
      document.addEventListener("DOMContentLoaded", adjustHeight, false)

  appleStandalone: window.navigator.standalone

  can: (property)->
    !!Modernizr[property]

  cant: (property)->
    !Browser.can(property)