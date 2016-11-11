io = null
database = null

join = (data) ->
  socket = this

  channelID = data.channelID
  username = data.username

  if socket.handshake.session.channelID != channelID
    socket.emit('eror', {message: 'Authentication failed.'})
    return

  channel = database.find(channelID)
  if !channel
    socket.emit('eror', {message: 'Authentication failed.'})
    return

  socket.join(channelID)
  channel.connectSocket(username)

  message = username + ' joined channel ' + channelID
  io.sockets.in(channelID).emit('update', {message: message})
  console.log message

disconnect = ->
  socket = this
  session = socket.handshake.session

  channelID = session.channelID
  username = session.username

  channel = database.find(channelID)
  if !channel
    return

  channel.setTimeout(username)
  setTimeout( ->
    channel = database.find(channelID)
    if !channel
      return
    if !channel.findUser(username)
      message = username + ' left channel ' + channelID
      io.sockets.in(channelID).emit('update', {message: message})
      console.log message

    if channel.empty()
      database.delete(channelID)
  , 2000)

start = (data) ->
  socket = this
  session = socket.handshake.session

  if session.channelID != data.channelID ||
      session.username != data.username
    socket.emit('eror', {message: 'Authentication failed'})

  channel = database.find(data.channelID)
  if !channel
    socket.emit('eror', {message: 'Game not found.'})
    return

  channel.start()

playCard = (data) ->
  socket = this
  session = socket.handshake.session

  if session.channelID != data.channelID ||
      session.username != data.username
    socket.emit('eror', {message: 'Authentication failed.'})
    return

  channel = database.find(data.channelID)
  if !channel
    socket.emit('eror', {message: 'Game not found.'})
    return

  result = channel.action(session.username, 'playCard')
  if result.success
    playedCard = result.playedCard
    message = session.username + ' played the ' + playedCard.toString()
    io.sockets.in(session.channelID).emit('move', {
      username: session.username,
      card: playedCard,
      message: message
    })

slap = (data) ->
  socket = this
  session = socket.handshake.session

  if session.channelID != data.channelID ||
      session.username != data.username
    socket.emit('eror', {message: 'Authentication failed.'})
    return

  channel = database.find(data.channelID)
  if !channel
    socket.emit('eror', {message: 'Game not found.'})
    return

  result = channel.action(session.username, 'slap')
  if result.success
    message = session.username + ' slapped successfully!'
    io.sockets.in(session.channelID).emit('slap', {
      username: session.username,
      success: true,
      message: message
    })
  else
    burnedCard = result.burnedCard
    message = session.username + ' slapped unsuccessfully and'
    if burnedCard == null
      message += ' has an empty hand'
    else
      message += ' burned the ' + burnedCard.toString()
    io.sockets.in(session.channelID).emit('slap', {
      username: session.username,
      success: false,
      card: burnedCard,
      message: message
    })

module.exports.attach = (socketIO, db) ->
  database = db
  io = socketIO

  io.sockets.on('connection', (socket) ->
    socket.on('join', join)
    socket.on('disconnect', disconnect)
    socket.on('start', start)
    socket.on('playCard', playCard)
    socket.on('slap', slap)
  )
