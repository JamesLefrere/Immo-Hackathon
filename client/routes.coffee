Router.configure layoutTemplate: "layout"
Router.map ->
  @route "home",
    path: "/"
    template: "home"
  @route "shortlist",
    path: "/shortlist"
    template: "shortlist"
    data: ->
      tenant = Tenants.findOne(userId: Meteor.userId())
      tenant: tenant
      properties: Properties.find(_id: $in: tenant.shortlist)

  @route "visits",
    path: "/visits"
    template: "visits"
    data: ->
      VisitDates.find()
  @route "bids",
    path: "/bids"
    template: "bids"
    data: ->
      Applications.find()

#  @route "viewProperty",
#    path: "/property/:slug"
#    template: "viewProperty"
#    data: ->
#      slug = @params.slug

#  @route "properties",
#    path: "/property"
#    template: "properties"
#    data:
#      properties: ->
#        Properties.find()
