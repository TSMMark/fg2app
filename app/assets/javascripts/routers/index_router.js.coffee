class Fg2app.Routers.Index extends Support.SwappingRouter

  routes:
    '(/)'            : 'index'
    '*notFound'      : 'notFound'
  
  index: ->
    dash    = new Fg2app.Views.Dashboard.Fullpage
      el: Fg2app.$.container
    dash.render()

  notFound: ->
    Backbone.history.navigate ''
