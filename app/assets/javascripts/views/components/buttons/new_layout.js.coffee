class Fg2app.Views.Components.Buttons.NewLayoutButton extends Fg2app.Views.Elements.Button
  
  constructor: (params={})->
    params = _.extend params, 
      attributes: 
        class: 'btn-new-layout'
      icon_left:    'icon-plus'
      icon_right:   'icon-chevron-sign-down icon-expander'
      button_text:  'New Layout' 
    super params