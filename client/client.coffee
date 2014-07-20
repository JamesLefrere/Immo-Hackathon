Toast.defaults.displayDuration = 800
Toast.defaults.fadeOutDuration = 100

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
          visit.status = 'Accepted'
        when 'visitDenied'
          visit.statusClass = 'danger'
          visit.status = 'Denied'
        else
          visit.statusClass = 'info'
          visit.status = 'Applying'
      visits.push(visit)
    )
    visits
  formattedApplications: ->
    applications = []
    _.each(@.applications.fetch(), (application) ->
      switch application.status
        when 'bidAccepted'
          application.statusClass = 'success'
          application.status = 'Bid accepted'
        when 'bidLow'
          application.statusClass = 'warning'
          application.status = 'Bid not accepted'
        when 'denied'
          application.statusClass = 'danger'
          application.status = 'Denied'
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
  'click .deny-bid': (e, t) ->
    Meteor.call 'denyBid', @, (err, res) ->
      unless err
        Toast.success 'Bid too low'
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
  'click .set-visiting': (e, t) ->
    Meteor.call 'setVisiting', @, (err, res) ->
      unless err
        Toast.success 'Set as visiting'
      else
        Toast.warning err.reason
    return

Template.bids.helpers
  # not DRY but too late
  formattedApplications: ->
    applications = []
    tenant = @.tenant
    _.each(@.applications.fetch(), (application) ->
      application.date = moment(application.date).format('DD/MM/YY hh:mm')
      application.property = Properties.findOne(application.propertyId)
      switch application.status
        when 'bidAccepted'
          application.statusClass = 'success'
          application.status = 'Bid accepted'
        when 'bidLow'
          application.statusClass = 'warning'
          application.status = 'Bid not accepted'
        when 'denied'
          application.statusClass = 'danger'
          application.status = 'Denied'
        else
          application.statusClass = 'info'
      application.isMe = true if application.tenantId = tenant._id
      applications.push(application)
    )
    applications

Template.bids.events
  'click .plus': (e, t) ->
    e.preventDefault()
    $bidAmount = $('#bidAmount-' + @._id)
    $bidAmount.val(parseInt($bidAmount.val()) + 10)
    $bidAmount.trigger('change')
  'click .minus': (e, t) ->
    e.preventDefault()
    $bidAmount = $('#bidAmount-' + @._id)
    $bidAmount.val(parseInt($bidAmount.val()) - 10)
    $bidAmount.trigger('change')
  'change .bid-amount': (e, t) ->
    e.preventDefault()
    @.bid = $('#bidAmount-' + @._id).val()
    Meteor.call 'submitBid', @, (err, res) ->
      unless err
        Toast.success 'Bid submitted'
      else
        Toast.warning err.reason

Template.myDetails.events
  'change #photoWidget': (e, t) ->
    tenant = @.tenant;
    FS.Utility.eachFile e, (file) ->
      Images.insert file, (err, fileObj) ->
        console.log(err)
        console.log(fileObj)
        Meteor.setTimeout (->
          $('#photo').val(fileObj.url())
        ), 2000
        return
      return
    return