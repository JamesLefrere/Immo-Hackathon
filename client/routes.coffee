Router.configure layoutTemplate: "layout"
Router.map ->
  @route "home",
    path: "/"
    template: "home"

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
