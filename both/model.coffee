@Tenants = new Meteor.Collection 'tenants',
  schema:
    userId:
      type: String
      optional: true
#      autoValue: ->
#        @.userId()
    phone:
      type: String
      optional: true
    people:
      type: Number
      optional: true
    photo:
      type: String
      optional: true
    documents:
      type: [String]
      optional: true
    income:
      type: Number
      optional: true
    creditScore:
      type: Number
      optional: true
    pets:
      type: String
      optional: true
    occupation:
      type: String
      optional: true
    shortlist:
      type: [String]
      optional: true

@Properties = new Meteor.Collection 'properties',
  schema:
    title:
      type: String
      max: 200
    is24Id:
      type: Number
    owner:
      type: String
#      autoValue: ->
#        @.userId()
    address:
      type: String
      max: 200
    photos:
      type: [String]
    visitDates:
      type: [Date]
      optional: true
#    slug:
#      type: String
#      autoValue: ->
#        _.slugify(this.siblingField('title').value)

@Applications = new Meteor.Collection 'applications',
  schema:
    propertyId:
      type: String
    tenantId:
      type: String
    date:
      type: Date
    tenantName:
      type: String
    status:
      type: String
    bid:
      type: Number
      optional: true
