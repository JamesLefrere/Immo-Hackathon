Template.home.helpers
  isTenant: ->
    Meteor.user() && Meteor.user().username != 'Herr Landlord'
  isLandlord: ->
    Meteor.user() && Meteor.user().username == 'Herr Landlord'
  createdAccount: ->
    Tenants.find(userId: Meteor.userId()).fetch().length > 0

Template.nav.helpers
  isTenant: ->
    Meteor.user() && Meteor.user().username != 'Herr Landlord'
  isLandlord: ->
    Meteor.user() && Meteor.user().username == 'Herr Landlord'

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
        Toast.success 'Application submitted'
      else
        Toast.warning err.reason
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
          visit.statusClass = 'danger'
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
        when 'bidLow'
          application.statusClass = 'warning'
        when 'bidDenied'
          application.statusClass = 'danger'
        else
          application.statusClass = 'info'
      applications.push(application)
    )
    applications

Template.manageProperty.events
  'click .accept-visit': (e, t) ->
    Meteor.call 'acceptVisit', @, (err, res) ->
      unless err
        Toast.success 'Visit accepted'
      else
        Toast.warning err.reason
    return
  'click .deny-visit': (e, t) ->
    Meteor.call 'denyVisit', @, (err, res) ->
      unless err
        Toast.success 'Visit denied'
      else
        Toast.warning err.reason
    return
  'click .accept-application': (e, t) ->
    Meteor.call 'acceptApplication', @, (err, res) ->
      unless err
        Toast.success 'Application accepted'
      else
        Toast.warning err.reason
    return
  'click .deny-application': (e, t) ->
    Meteor.call 'denyApplication', @, (err, res) ->
      unless err
        Toast.success 'Application denied'
      else
        Toast.warning err.reason
    return

Template.bids.events
  'submit .bid-form': (e, t) ->
    e.preventDefault()
    @.bid = $('#bidAmount-' + @._id).val()
    Meteor.call 'submitBid', @, (err, res) ->
      unless err
        Toast.success 'Bid submitted'
      else
        Toast.warning err.reason