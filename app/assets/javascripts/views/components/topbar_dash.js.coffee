class Fg2app.Views.DashTopbar extends Fg2app.Views.Topbar

  initialize: ->
    current_option = @stave('current_option') || @default_option
    @setCurrentOption current_option
    # @stave ''

  default_option: 'complete'
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
      action: 'archive'
      icon: 'inbox'
      label: 'Archive'
    }]