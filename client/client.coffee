Template.home.helpers
  isTenant: ->
    Meteor.user() && Meteor.user().username != 'Herr Landlord'
  createdAccount: ->
    Tenants.find({ userId: Meteor.userId() }).fetch().length > 0