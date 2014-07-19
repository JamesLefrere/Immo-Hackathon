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
      properties = Properties.find(_id: $in: tenant.shortlist)
      tenant: tenant
      properties: properties

  @route 'visits',
    path: '/visits'
    template: 'visits'
    data: ->
      tenant = Tenants.findOne(userId: Meteor.userId())
      properties = Properties.find(_id: $in: tenant.shortlist)
      visitDates = VisitDates.find(propertyId: $in: tenant.shortlist)
      tenant: tenant
      properties: properties
      visitDates: visitDates

  @route 'singleVisit',
    path: '/visits/:_id'
    template: 'singleVisit'
    data: ->
      tenant = Tenants.findOne(userId: Meteor.userId())
      property = Properties.findOne(_id: @.params._id)
      visitDates = VisitDates.find(propertyId: @.params._id)
      tenant: tenant
      property: property
      visitDates: visitDates

  @route 'bids',
    path: '/bids'
    template: 'bids'
    data: ->
      Applications.find(owner: Meteor.userId())
