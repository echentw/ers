CardQueue = require('./cards/cardqueue')
Deck = require('./cards/deck')

class Game

  constructor: (usernames) ->

    @users = {}
    for username in usernames
      @users[username] = new CardQueue()

    deck = new Deck()
    deck.shuffle()

    while not deck.isEmpty()
      for username in usernames
        @users[username].push(deck.deal())
        if deck.isEmpty()
          break

    @order = []
    for username in usernames
      @order.push(username)

    @pile = new CardQueue()

    @turn = 0

  playCard: (username) =>
    if username != @order[@turn]
      return

    card = @users[username].pop()
    @pile.push(card)

    console.log (username + " plays the " + card.toString())

    @turn = (@turn + 1) % (Object.keys(@users).length)

  slap: (username) =>
    console.log (username + " slaps")
    if @pile.isDouble() or @pile.isSandwich()
      console.log (username + " slaps correctly!")
      while not @pile.isEmpty()
        card = @pile.pop()
        @users[username].push(card)
    else
      if @users[username].isEmpty()
        return
      card = @users[username].pop()
      @pile.burnPush(card)
      console.log (username + " burns the " + card.toString())

module.exports = Game
