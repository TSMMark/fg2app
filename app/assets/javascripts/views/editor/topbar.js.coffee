class Fg2app.Views.Editor.EditorTopbar extends Fg2app.Views.TopbarClass

  initialize: ->
    super

  default_option: null

  side_panels: null

  are_tabs: false

  topbar_options:
    [{
      action: 'navigate.dashboard'
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