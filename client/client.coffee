Template.home.helpers
  isTenant: ->
    Meteor.user() && Meteor.user().username != 'Herr Landlord'
  isLandlord: ->
    Meteor.user() && Meteor.user().username == 'Herr Landlord'
  createdAccount: ->
    Tenants.find(userId: Meteor.userId()).fetch().length > 0

Template.manageProperties.helpers
  properties: ->
    Properties.find(owner: Meteor.userId())

Template.shortlist.helpers
  readyForApplication: ->
#    console.log(@)
    true #hax

Template.manageProperty.helpers
  currentVisitDates: ->
    VisitDates.findOne(propertyId: @.property._id)
  visitDatesUpdate: ->
    VisitDates.find(propertyId: @.property._id).fetch().length > 0 if @.property

