class Fg2app.Models.Layout extends Backbone.Model
  # url:      '/api/v1/layouts'
  urlRoot:  '/api/v1/layouts'
  
  initialize: ->
    @set 'thumb', @_randomImage()

  validate: ->

  isComplete: =>
    !!@get('description').match(/description/i)

  matchesTerms: (terms)=>
    regexp = new RegExp(terms, "i")
    match = @get('description').match(regexp) || 
            @get('name').match(regexp)
    !!match


  _randomImage: =>
    imgs = _ [
      'https://fbcdn-photos-h-a.akamaihd.net/hphotos-ak-prn1/851580_10151619252892618_605899372_n.png',
      'https://fbcdn-photos-h-a.akamaihd.net/hphotos-ak-ash3/851565_10151949827252501_1360611202_n.gif',
      'https://photos-a-lga.xx.fbcdn.net/hphotos-ash3/851583_504893306250124_154024973_n.jpg',
      'https://fbcdn-photos-d-a.akamaihd.net/hphotos-ak-prn1/851560_10151727615332495_132929428_n.jpg'
    ]
    imgs.shuffle().pop()