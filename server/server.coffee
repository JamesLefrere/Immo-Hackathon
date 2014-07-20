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
    Accounts.createUser
      username: 'Herr Landlord'
      password: 'test'
      email: 'landlord@example.com'
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
  if !Properties.find(is24Id: 62514911).fetch().length > 0
    landlord = Meteor.users.findOne(username: 'Herr Landlord')
    property = Properties.insert
      address: "Andreasstraße 10, 10243 Berlin, Friedrichshain (Friedrichshain)"
      is24Id: 62514911
      owner: landlord._id
      visitDates: [
        new Date()
      ]
      photos: [
        "http://picture.preview-is24.de/pic/orig04/N/103/322/875/103322875-0.jpg/ORIG/resize/400x300%3E/format/jpg?3045567103"
      ]
      slug: "test-is24-att-wohnung-miete-trustworthy"
      title: "Test-IS24-ATT: Wohnung Miete (trustworthy)"
    jane = Meteor.users.findOne(username: 'Jane')._id
    Tenants.insert
      userId: jane
      phone: '999'
      people: 1
      photo: 'http://images.forbes.com/media/lists/11/2008/34AH.jpg'
      documents: [
        'Example 1', 'Example 2'
      ]
      income: 2500
      creditScore: 3
      occupation: 'Developer'
      shortlist: [ property ]
    bob = Meteor.users.findOne(username: 'Bob')._id
    Tenants.insert
      userId: bob
      phone: '92673299'
      people: 2
      photo: 'http://images.forbes.com/media/lists/11/2008/34AH.jpg'
      documents: [
        'Example 1', 'Example 2'
      ]
      income: 2000
      creditScore: 4
      occupation: 'Builder'
      shortlist: [ property ]