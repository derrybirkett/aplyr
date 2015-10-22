Template.registerHelper "profileHasLoaded", (argument) ->
  Session.get "profileHasLoaded"

Template.profile.rendered = ->
  Session.set "profileHasLoaded", false
  Session.set "viewingUser", this.data._id

  # Pull down user profile
  viewuser = Meteor.call "loadUserProfile", this.data.services.github.username, (error, result) ->
    if(error)
      console.log "Not found user", error
    if(result)
      # console.log "Found user: "+ Session.get("viewingUser"), result.data
      updateuser = Meteor.call "updateUserProfile", ({"user":Session.get("viewingUser"),"data":result.data}), (error, result) ->
        if(error)
          console.log "Not updated user!", error
        if(result)
          console.log "Updated user profile."
      Session.set "profileHasLoaded", true
