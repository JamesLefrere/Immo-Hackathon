Router.configure layoutTemplate: 'layout'

Router.map ->
  @route 'home',
    path: '/'
    template: 'home'

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
      properties = Properties.find(_id: $in: tenant.shortlist)
      tenant: tenant
      properties: properties

  @route 'singleVisit',
    path: '/visits/:_id'
    template: 'singleVisit'
    data: ->
      tenant = Tenants.findOne(userId: Meteor.userId())
      property = Properties.findOne(_id: @.params._id)
      tenant: tenant
      property: property

  @route 'bids',
    path: '/bids'
    template: 'bids'
    data: ->
      Applications.find(owner: Meteor.userId())

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
      applications = Applications.find(propertyId: @.params._id)
      property: property
      applications: applications

