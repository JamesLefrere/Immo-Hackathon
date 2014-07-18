Meteor.methods
  'submitApplication': (data) ->
    Applications.insert(data)

Meteor.startup ->
#  Accounts.createUser
#    username: 'Alice'
#    password: 'test'
#    email: 'alice@example.com'
#  Accounts.createUser
#    username: 'Bob'
#    password: 'test'
#    email: 'bob@example.com'
#  Accounts.createUser
#    username: 'Tim'
#    password: 'test'
#    email: 'tim@example.com'
#  Accounts.createUser
#    username: 'Jane'
#    password: 'test'
#    email: 'jane@example.com'
#  Accounts.createUser
#    username: 'Herr Landlord'
#    password: 'test'
#    email: 'landlord@example.com'

