@Properties = new Meteor.Collection 'properties',
  schema:
    title:
      type: String
      max: 200
    coldRent:
      type: Number
    warmRent:
      type: Number
    agent:
      type: String
    slug:
      type: String
      autoValue: ->
        _.slugify(this.siblingField('title').value)

@Applications = new Meteor.Collection 'applications'