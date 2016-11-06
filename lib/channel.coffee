Game = require('./game')

class Channel
  constructor: ->
    @users = {}
    @disconnectedUsers = {}
    @game = null

  findUser: (username) =>
    return username of @users

  addUser: (username) =>
    if username of @users
      return false
    @users[username] = true
    return true

  removeUser: (username) =>
    if username of @users
      delete @users[username]
      if username of @disconnectedUsers
        delete @disconnectedUsers[username]
      return true
    return false

  # maintain a more stable connection
  # remove the user from the channel after 1.5 seconds,
  # if user has not reconnected within that time
  setTimeout: (username) =>
    if username of @users
      @disconnectedUsers[username] = true
      setTimeout( =>
        if @disconnectedUsers[username]
          @removeUser(username)
      , 1500)

  # maintain a more stable connection
  # add the user back in if the user reconnects within 1.5 seconds
  connectSocket: (username) =>
    if username of @users
      if username of @disconnectedUsers
        delete @disconnectedUsers[username]

  empty: ->
    return Object.keys(@users).length == 0

  start: =>
    usernames = []
    for username of @users
      usernames.push(username)
    @game = new Game(usernames)

  action: (username, action) =>
    if @game
      if action == 'playCard'
        @game.playCard(username)
      else if action == 'slap'
        @game.slap(username)

module.exports = Channel
