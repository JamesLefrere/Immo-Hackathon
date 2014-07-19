Template.home.helpers
  isTenant: ->
    Meteor.user() && Meteor.user().username != 'Herr Landlord'
  isLandlord: ->
    Meteor.user() && Meteor.user().username == 'Herr Landlord'
  createdAccount: ->
    Tenants.find(userId: Meteor.userId()).fetch().length > 0

Template.addLandlord.helpers
  currentLandlord: ->
    Landlords.findOne(userId: Meteor.userId())