class Fg2app.Routers.Index extends Support.SwappingRouter

  routes:
    'layouts/new'           : 'newLayout'
    'layouts/:id(/)'        : 'layout'
    'dashboard(/)(:id)(/)'  : 'dashboard'
    'layouts(/)'            : 'layouts'

    '([/#_])'               : 'index'
    '*notFound'             : 'notFound'
  
  initialize: ->
    @$el =  Fg2app.$container

  index: (id)->
    @dashboard id
  
  dashboard: (id)->
    Global.set 'route', 'dash'
    view  = new Fg2app.Views.Dashboard.Fullpage
      open_layout:  id
    @swap view

  newLayout: ->
    view  = new Fg2app.Views.Editor.NewLayout
    @swap view

  layout: (id)->
    @index id

  layouts: ->
    @index()

  notFound: ->
    Navigate ''
