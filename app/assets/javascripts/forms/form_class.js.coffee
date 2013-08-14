class Fg2app.Forms.FormClass extends Backbone.Form

  constructor: (params)->
    @leaveablize()
    super params


_.extend Fg2app.Forms.FormClass.prototype, Support.Mixin.Leaveable