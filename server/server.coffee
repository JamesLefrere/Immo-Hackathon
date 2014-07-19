Meteor.methods
  'submitApplication': (data) ->
    Applications.insert(data)

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
    Properties.insert
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