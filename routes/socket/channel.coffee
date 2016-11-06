io = null
database = null

join = (data) ->
  socket = this

  channelID = data.channelID
  username = data.username

  if socket.handshake.session.channelID != channelID
    return

  channel = database.find(channelID)
  if !channel
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

hit = (data) ->
  socket = this
  session = socket.handshake.session

  if session.channelID != data.channelID ||
      session.username != data.username
    return

  message = session.username + ' pinged channel ' + session.channelID
  io.sockets.in(session.channelID).emit('update', {message: message})
  console.log message

module.exports.attach = (socketIO, db) ->
  database = db
  io = socketIO

  io.sockets.on('connection', (socket) ->
    socket.on('join', join)
    socket.on('disconnect', disconnect)
    socket.on('hit', hit)
  )
