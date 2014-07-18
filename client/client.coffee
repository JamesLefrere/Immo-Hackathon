Template.home.helpers
  isTenant: ->
    Meteor.user().username != 'Herr Landlord'