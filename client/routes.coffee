Router.configure layoutTemplate: 'layout'

Router.map ->
  @route 'home',
    path: '/'
    template: 'home'

  @route 'my-details',
    path: '/my-details'
    template: 'myDetails'
    data: ->
      tenant: Tenants.findOne(userId: Meteor.userId())

  @route 'shortlist',
    path: '/shortlist'
    template: 'shortlist'
    data: ->
      tenant = Tenants.findOne(userId: Meteor.userId())
      properties = Properties.find(_id: $in: tenant.shortlist) if tenant
      applications = Applications.find(owner: Meteor.userId())
      tenant: tenant
      properties: properties
      applications: applications

  @route 'visits',
    path: '/visits'
    template: 'visits'
    data: ->
      tenant = Tenants.findOne(userId: Meteor.userId())
      applications = Applications.find(tenantId: Meteor.userId())
      properties = Properties.find(_id: $in: tenant.shortlist) if tenant
      tenant: tenant
      applications: applications
      properties: properties

  @route 'singleVisit',
    path: '/visits/:_id'
    template: 'singleVisit'
    data: ->
      tenant = Tenants.findOne(userId: Meteor.userId())
      property = Properties.findOne(_id: @.params._id)
      application = Applications.findOne(tenantId: tenant._id)
      tenant: tenant
      property: property
      application: application

  @route 'singleTenant',
    path: '/tenant/:_id'
    template: 'singleTenant'
    data: ->
      tenant = Tenants.findOne(_id: @.params._id)
      application = Applications.findOne(tenantId: @.params._id)
      user = Meteor.users.findOne(_id: tenant.userId) if tenant
      tenant: tenant
      application: application
      user: user

  @route 'bids',
    path: '/bids'
    template: 'bids'
    data: ->
      tenant = Tenants.findOne(userId: Meteor.userId())
      applications = Applications.find(tenantId: tenant._id) if tenant
      tenant: tenant
      applications: applications

  @route 'manageProperties',
    path: 'manage-properties'
    template: 'manageProperties'
    data: ->
      properties: Properties.find(owner: Meteor.userId())

  @route 'manageProperty',
    path: 'manage-property/:_id'
    template: 'manageProperty'
    data: ->
      property = Properties.findOne(_id: @.params._id)
      applications = Applications.find
        propertyId: @.params._id
        status: $in: ['visiting', 'bidAccepted', 'bidLow', 'denied']
      ,
        sort:
          date: -1
      visits = Applications.find(
        propertyId: @params._id
        status: $in: ['applyingForVisit', 'visitAccepted', 'visitDenied']
      ,
        sort:
          bid: -1
          date: -1
      )
      property: property
      applications: applications
      visits: visits
