class Fg2app.Views.Dashboard.DashboardTopbar extends Fg2app.Views.Topbar

  side_panels: [ 'left' , 'right' ]

  initialize: ->
    super

  default_option: 'active'
  topbar_options:
    [{
      action: 'active'
      icon: 'time'
      label: 'Active'
    },{
      action: 'expired'
      icon: 'exclamation-sign'
      label: 'Expired'
    },{
      action: 'complete'
      icon: 'ok'
      label: 'Complete'
    },{
      action: 'tags'
      icon: 'cloud'
      label: 'Tags'
    },{
      action: 'archived'
      icon: 'inbox'
      label: 'Archived'
    }]