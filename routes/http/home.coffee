database = null

# GET home page
home = (req, res, next) ->
  res.render('home')
  return

# POST create a channel
createChannel = (req, res, next) ->
  # clear the current session
  req.session.channelID = null
  req.session.username = null

  # create new session
  channelID = database.add()
  req.session.channelID = channelID
  req.session.username = req.body['username']

  # add the creator to list of users
  channel = database.find(channelID)
  channel.addUser(req.session.username)

  res.redirect('/channel/' + channelID)

# Attach route handlers to the app
module.exports.attach = (app, db) ->
  database = db
  app.get('/', home)
  app.post('/create', createChannel)
