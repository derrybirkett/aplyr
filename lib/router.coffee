Router.configure
  layoutTemplate:   'layout',
  loadingTemplate:  'spinner'
  waitOn: ->
    Meteor.subscribe 'users'

Router.route '/about',
  name: "About"

Router.route '/directory',
  name: 'Directory'
  data: ->
    user: ->
        Meteor.users.find()

Router.route '/:username',
  name: 'Profile'
  data: ->
    Meteor.users.findOne({"services.github.username": this.params.username})

Router.route '/',
  name: 'home'
  data: ->
    user: ->
      Meteor.users.find()
  onBeforeAction: ->
    if user = Meteor.user()
      Router.go 'Profile', {username: user.services.github.username}
    else
      this.next()
