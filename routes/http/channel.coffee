database = null

# GET channel page
channel = (req, res, next) ->
  channelID = req.params['id']

  # if not an existing session, start a new one
  if !req.session.username || req.session.channelID != channelID
    res.render('join', {channelID: req.params.id, message: ''})
    return

  res.render('channel', {
    channelID: req.session.channelID,
    username: req.session.username
  })

# POST join channel
join = (req, res, next) ->
  username = req.body['username']
  channelID = req.body['channelID']

  channel = database.find(channelID)
  if !channel
    res.render('join', {
      channelID: channelID,
      message: 'Channel not found.'
    })

  success = channel.addUser(username)
  if !success
    res.render('join', {
      channelID: channelID,
      message: 'That username has been taken.'
    })

  req.session.username = username
  req.session.channelID = channelID

  res.redirect('/channel/' + channelID)

module.exports.attach = (app, db) ->
  database = db
  app.get('/channel/:id', channel)
  app.post('/channel/:id/join', join)
