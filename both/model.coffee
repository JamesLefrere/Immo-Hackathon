@Tenants = new Meteor.Collection 'tenants',
  schema:
    userId:
      type: String
      autoValue: ->
        Meteor.userId()
    phone:
      type: String
    people:
      type: Number
    photo:
      type: String
    documents:
      type: [String]
    income:
      type: Number
    creditScore:
      type: Number
    pets:
      type: String
    occupation:
      type: String
    shortlist:
      type: [Number]

@Properties = new Meteor.Collection 'properties',
  schema:
    title:
      type: String
      max: 200
    is24Id:
      type: Number
    address:
      type: String
      max: 200
    photos:
      type: [String]
    slug:
      type: String
      autoValue: ->
        _.slugify(this.siblingField('title').value)

@VisitDates = new Meteor.Collection 'visitDates',
  schema:
    propertyId:
      type: String
    date:
      type: Date

@Applications = new Meteor.Collection 'applications',
  schema:
    visitDateId:
      type: String
    tenantId:
      type: String
    status:
      type: Boolean
    bid:
      type: Number
