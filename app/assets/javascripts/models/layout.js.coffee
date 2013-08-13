class Fg2app.Models.Layout extends Backbone.Model
  # url:      '/api/v1/layouts'
  urlRoot:  '/api/v1/layouts'
  
  initialize: ->
    @set 'thumb', @_randomImage()

  validate: ->

  matchesTerms: (terms)=>
    regexp = new RegExp(terms, "i")
    match = @get('description').match(regexp) || 
            @get('name').match(regexp)
    !!match


  isActive: =>
    seconds_passed = new Date().getTime() - new Date(@get('created_at')).getTime() 
    seconds_passed <= 604800

  isExpired: =>
    seconds_passed = new Date().getTime() - new Date(@get('created_at')).getTime() 
    seconds_passed > 604800

  isComplete: =>
    !!@get('description').match(/description/i)

  isArchived: =>
    # !!@get('description').match(/description/i)
    false

  _randomImage: =>
    imgs = _ [
      'https://fbcdn-photos-h-a.akamaihd.net/hphotos-ak-prn1/851580_10151619252892618_605899372_n.png',
      'https://fbcdn-photos-h-a.akamaihd.net/hphotos-ak-ash3/851565_10151949827252501_1360611202_n.gif',
      'https://photos-a-lga.xx.fbcdn.net/hphotos-ash3/851583_504893306250124_154024973_n.jpg',
      'https://fbcdn-photos-d-a.akamaihd.net/hphotos-ak-prn1/851560_10151727615332495_132929428_n.jpg',
      'https://fbcdn-photos-f-a.akamaihd.net/hphotos-ak-prn1/851579_151842485005742_1174228785_n.png',
      'https://fbcdn-photos-e-a.akamaihd.net/hphotos-ak-ash3/851579_10151591660830975_873283020_n.png',
      'https://fbcdn-photos-b-a.akamaihd.net/hphotos-ak-prn1/851585_10151657338406499_852492637_n.gif',
      'https://fbcdn-photos-b-a.akamaihd.net/hphotos-ak-prn1/851586_10151657338381499_647951253_n.gif',
      'https://fbcdn-photos-g-a.akamaihd.net/hphotos-ak-prn1/851562_443659299060007_2032650863_n.gif'
    ]
    imgs.shuffle().pop()


  schema:
    name:         'Text'
    description:  'Text'






