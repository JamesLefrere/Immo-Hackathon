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
          date: moment(date).format('YYYY MM DD hh:mm')
        return
      dates
  userId: ->
    Meteor.userId()
  username: ->
    Meteor.user().username if Meteor.user()

Template.singleVisit.events
  'submit #applicationForm': (e, t) ->
    e.preventDefault()
    data =
      date: new Date($('#date').val())
      tenantId: @tenant._id
      tenantName: Meteor.user().username
      propertyId: @property._id
      status: 'applyingForVisit'
    Meteor.call 'submitApplication', data, (err, res) ->
      unless err
        FlashMessages.sendSuccess 'Application submitted'
      else
        FlashMessages.sendWarning err.reason
    return

Template.manageProperty.helpers
  formattedVisits: ->
    visits = []
    _.each(@.visits.fetch(), (visit) ->
      visit.date = moment(visit.date).format('DD/MM/YY')
      switch visit.status
        when 'visitAccepted'
          visit.statusClass = 'success'
        when 'visitDenied'
          visit.statusClass = 'error'
        else
          visit.statusClass = 'info'
      visits.push(visit)
    )
    visits
  formattedApplications: ->
    applications = []
    _.each(@.applications.fetch(), (application) ->
      switch application.status
        when 'bidAccepted'
          application.statusClass = 'success'
        when 'bidDenied'
          application.statusClass = 'warning'
        when 'outrightDenied'
          application.statusClass = 'error'
        else
          application.statusClass = 'info'
      applications.push(application)
    )
    applications
