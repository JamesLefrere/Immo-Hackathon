Template.home.helpers
  isTenant: ->
    Meteor.user() && Meteor.user().username != 'Herr Landlord'
  isLandlord: ->
    Meteor.user() && Meteor.user().username == 'Herr Landlord'
  createdAccount: ->
    Tenants.find(userId: Meteor.userId()).fetch().length > 0

Template.shortlist.helpers
  readyForApplication: ->
#    console.log(@)
    true #hax

#Template.manageProperty.helpers
#  currentVisitDates: ->
#    VisitDates.findOne(propertyId: @.property._id)

Template.singleVisit.helpers
  formattedDates: ->
    dates = []
    if @property
      _.each @property.visitDates, (date) ->
        dates.push
          humanDate: moment(date).format('DD/MM/YY hh:mm')
          date: date
        return
      dates
  userId: ->
    Meteor.userId()
  username: ->
    Meteor.user().username