Meteor.methods
  searchUsers: (query) ->
    # DEV
    @unblock()
    Meteor.http.call "GET", "https://api.github.com/seach/users?q=" + query
      headers:
        "User-Agent": "d2tstudio"

  loadUserProfile: (username) ->
    @unblock()
    Meteor.http.call "GET", "https://api.github.com/users/" + username,
      headers:
        "User-Agent": "d2tstudio"

  updateUserProfile: (obj) ->
    Meteor.users.update obj.user,
      $set: {'services.github.scheda': obj.data}
