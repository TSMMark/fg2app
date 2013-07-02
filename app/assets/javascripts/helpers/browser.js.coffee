window.Browser   = 
  # hide mobile safari's addressbar on load.
  hideAddressBar: (instant=false)->
    # 1 double html height
    # 2 scroll the page down to hide the addressbar
    #   - this sets window.innerHeight to the full browser height excluding the addressbar
    # 3 set html height to 100% # window.innerHeight
    # TODO: verify window rotation
    adjustHeight = ->
      html = document.documentElement
      size = window.innerHeight
      html.style.height = (size + size) + "px"
      window.setTimeout((->
        if (window.pageYOffset == 0)
          window.scrollTo(0, 0)
        html.style.height = "100%" # window.innerHeight + "px"
      ), 1)

    # make sure not in fullscreen safari
    # if(Browser.appleStandalone == false)
      # listen for content loaded
      document.addEventListener("DOMContentLoaded", adjustHeight, false)

  appleStandalone: window.navigator.standalone

  can: (property)->
    !!Modernizr[property]

  cant: (property)->
    !Browser.can(property)