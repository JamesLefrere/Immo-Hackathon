Meteor.methods
  'submitApplication': (data) ->
    Applications.insert(data)