Template.home.helpers
  isTenant: ->
    Meteor.user() && Meteor.user().username != 'Herr Landlord'