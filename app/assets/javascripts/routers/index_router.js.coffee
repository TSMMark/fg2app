class Fg2app.Routers.Index extends Support.SwappingRouter

  routes:
    'layouts/new'     : 'newLayout'
    'layouts/:id(/)'  : 'layout'
    'layouts(/)'      : 'layouts'
    'foo'             : 'foo'

    '([/#_])'         : 'index'
    '*notFound'       : 'notFound'
  
  initialize: ->
    @$el =  Fg2app.$container

  index: (id)->
    Global.set 'route', 'dash'
    view  = new Fg2app.Views.Dashboard.Fullpage
      open_layout:  id

    @swap view
  
  foo: ->
    view  = new Fg2app.Views.Dashboard.Fullpage
    @swap view

  newLayout: ->
    view  = new Fg2app.Views.Editor.NewLayout
    @swap view

  notFound: ->
    Navigate ''

  layout: (id)->
    @index id

  layouts: ->
    @index()