class Fg2app.Routers.Index extends Support.SwappingRouter

  routes:
    'layouts/:id(/)'  : 'layout'
    'layouts(/)'      : 'layouts'
    '([/#_])'         : 'index'
    '*notFound'       : 'notFound'
  
  index: (id)->
    Global.set 'route', 'dash'
    dash    = new Fg2app.Views.Dashboard.Fullpage
      el:           Fg2app.$.container
      open_layout:  id

    dash.render()

  notFound: ->
    Backbone.history.navigate '', trigger:true

  layout: (id)->
    @index id

  layouts: ->
    @index()