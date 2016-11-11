define(['socket-io', 'jquery', 'card', 'card_path'], (io, $, Card, CardPath) ->

  class Client
    constructor: (channelID, username) ->
      @channelID = channelID
      @username = username
      @socket = getSocket()
      @socket.emit('join', {channelID: channelID, username: username})

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
        card = new Card(data.card.value, data.card.suit)
        cardPath = CardPath.getCardPath(card)

        $('#card').attr('class', 'card')
        $('#card').attr('src', cardPath)
        setTimeout( ->
          $('#card').attr('class', 'card animation-target')
        , 10)
      )
      socket.on('slap', (data) ->
        console.log data.message
        if data.success
          $('#card').attr('src', '')
      )
      socket.on('eror', (data) ->
        console.log data.message
      )
      return socket

  return Client
)
