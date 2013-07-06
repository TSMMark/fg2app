window.Browser   = 
  # hide mobile safari's addressbar on load.
  hideAddressBar: ()->
    # 1 double html height
    # 2 scroll the page down to hide the addressbar
    #   - this sets window.innerHeight to the full browser height excluding the addressbar
    # 3 set html height to 100% # window.innerHeight
    # 4 refire on window resize
    #   - only if height changed
    lastHeight = null
    adjustHeight = ->
      html = document.documentElement
      size = window.innerHeight
      return if lastHeight == size
      lastHeight = size
      html.style.height = (size + size) + "px"
      window.setTimeout((->
        if (window.pageYOffset == 0)
          window.scrollTo(0, 0)
        html.style.height = window.innerHeight + "px"
      ), 1)

    # make sure not in fullscreen safari
    if(Browser.appleStandalone == false)
      # listen for content loaded
      document.addEventListener("DOMContentLoaded", (->$(window).resize(adjustHeight).resize()), false)
  
  
  appleStandalone: window.navigator.standalone

  can: (property)->
    !!Modernizr[property]

  cant: (property)->
    !Browser.can(property)

# window.console object fo' browsahs dat don' alrdy got 1
window.console ||= 
  log:    (->)
  debug:  (->)
  info:   (->)
  warn:   (->)
  error:  (->)