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
        address: 'Linienstraße 216/217, 10119 Berlin, Mitte (Mitte)'
        is24Id: 74682602
        owner: landlord
        coldRent: 1975
        nebenkosten: 300
        visitDates: [
          new Date()
        ]
        photos: [
          '/img/bcg_slide-1.jpg',
          '/img/bcg_slide-2.jpg',
          '/img/bcg_slide-3.jpg',
          '/img/bcg_slide-4.jpg'
        ]
        slug: _.slugify('Apartment mit Dachterasse im Scheunenviertel | ERSTBEZUG')
        title: 'Apartment mit Dachterasse im Scheunenviertel | ERSTBEZUG'
        description: '<p>3 Rooms, 136.55 m², 2nd floor</p>
        <p>1.975 EUR (1975 base + 300 NK)</p>
        <p>LUXURIÖSER NEUBAU aus dem Jahr 2012</p>
        <ul>
          <li>Eingangs- und Wartehalle</li>
          <li>begrünter Hof mit Kinderspielplatz</li>
          <li>Briefkästen einzeln, jeweils an der Wohnungstür</li>
          <li>besonderes Augenmerk auf den Sicherheitsaspekt (geschlossene Tore zum Hof; Wohnungstür mit Metallkern und 3-fach Schließmechanismus)</li>
          <li>Aufzug</li>
          <li>Tiefgaragenstellplatz für 150 EUR monatlich inklusive</li>
        </ul>'
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
  return user if (user.username == 'Herr Landlord')
  properties = Properties.find().fetch()
  propertyIds = _.pluck(properties, '_id').join(',')
  Tenants.insert
    userId: user._id
    shortlist: [ propertyIds ]
  return user
