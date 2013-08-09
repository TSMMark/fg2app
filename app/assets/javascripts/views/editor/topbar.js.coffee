class Fg2app.Views.Editor.EditorTopbar extends Fg2app.Views.Topbar

  initialize: ->
    super

  default_option: null

  side_panels: null

  topbar_options:
    [{
      action: 'dashboard'
      icon: 'reply'
      label: 'Back to Dashboard'
    },{
      action: 'help'
      icon: 'question-sign'
      label: 'Help'
    },{
      action: 'exit'
      icon: 'save'
      label: 'Save and Exit'
    }]