define(['socket-io'], (io) ->

  class Client
    constructor: (channelID, username) ->
      @channelID = channelID
      @username = username
      @socket = getSocket()
      @socket.emit('join', {channelID: channelID, username: username})

    ping: =>
      @socket.emit('hit', {channelID: @channelID, username: @username})

    start: =>
      @socket.emit('start', {channelID: @channelID, username: @username})

    playCard: =>
      @socket.emit('playCard', {channelID: @channelID, username: @username})

    slap: =>
      @socket.emit('slap', {channelID: @channelID, username: @username})

    getSocket = ->
      socket = io.connect()
      socket.on('update', (data) ->
        console.log data.message
      )
      socket.on('move', (data) ->
        console.log data.message
      )
      socket.on('eror', (data) ->
        console.log data.message
      )
      return socket

  return Client
)
