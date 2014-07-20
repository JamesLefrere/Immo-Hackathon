Meteor.methods
  'submitApplication': (data) ->
    existing = Applications.findOne
      propertyId: data.propertyId
      tenantId: data.tenantId
    application = Applications.insert(data)
    if existing
      Applications.remove(existing)
      throw new Meteor.Error(200, 'New date selected')
    else
      application
  'submitBid': (data) ->
    existing = Applications.findOne
      propertyId: data.propertyId
      tenantId: data.tenantId
    application = Applications.update(data._id,
      $set:
        bid: data.bid
    )
    if !existing
      throw new Meteor.Error(404, 'Application not found')
    else
      application
  'acceptVisit': (data) ->
    Applications.update(data._id,
      $set:
        status: 'visitAccepted'
    )
  'denyVisit': (data) ->
    Applications.update(data._id,
      $set:
        status: 'visitDenied'
    )
  'acceptApplication': (data) ->
    Applications.update(data._id,
      $set:
        status: 'bidAccepted'
    )
  'denyBid': (data) ->
    Applications.update(data._id,
      $set:
        status: 'bidLow'
    )
  'denyApplication': (data) ->
    Applications.update(data._id,
      $set:
        status: 'denied'
    )
  'setVisiting': (data) ->
    Applications.update(data._id,
      $set:
        status: 'visiting'
    )

Meteor.startup ->
  if !Meteor.users.find(username: 'Herr Landlord').fetch().length > 0
    landlord = Accounts.createUser
      username: 'Herr Landlord'
      password: 'test'
      email: 'landlord@example.com'
    if !Properties.find(is24Id: 62514911).fetch().length > 0
      Properties.insert
        address: "Andreasstraße 10, 10243 Berlin, Friedrichshain (Friedrichshain)"
        is24Id: 62514911
        owner: landlord
        coldRent: 290
        visitDates: [
          new Date()
        ]
        photos: [
          "http://picture.preview-is24.de/pic/orig04/N/103/322/875/103322875-0.jpg/ORIG/resize/400x300%3E/format/jpg?3045567103"
        ]
        slug: "test-is24-att-wohnung-miete-trustworthy"
        title: "Test-IS24-ATT: Wohnung Miete (trustworthy)"
  if !Meteor.users.find(username: 'Alice').fetch().length > 0
    Accounts.createUser
      username: 'Alice'
      password: 'test'
      email: 'alice@example.com'
  if !Meteor.users.find(username: 'Bob').fetch().length > 0
    Accounts.createUser
      username: 'Bob'
      password: 'test'
      email: 'bob@example.com'
  if !Meteor.users.find(username: 'Tim').fetch().length > 0
    Accounts.createUser
      username: 'Tim'
      password: 'test'
      email: 'tim@example.com'
  if !Meteor.users.find(username: 'Jane').fetch().length > 0
    Accounts.createUser
      username: 'Jane'
      password: 'test'
      email: 'jane@example.com'

Accounts.onCreateUser (options, user) ->
  return if (user.username == 'Herr Landlord')
  properties = Properties.find().fetch()
  propertyIds = _.pluck(properties, '_id').join(',')
  Tenants.insert
    userId: user._id
    shortlist: [ propertyIds ]
  return user
