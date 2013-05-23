class Fg2app.Collections.Users extends Backbone.Collection
  url: '/api/users'
  # GET     /users
  # POST    /users
  # GET     /users/123
  # PUT     /users/123
  # DELETE  /users/123

  model: Fg2app.Models.User
