CardQueue = require('./cards/cardqueue')
Deck = require('./cards/deck')

class Game

  constructor: (usernames) ->
    @numPlayers = usernames.length
    @pile = new CardQueue()
    @turn = 0

    @handsByUsername = {}
    @orderByUsername = {}
    @ordering = (-1 for i in [0 ... @numPlayers])
    for username, order in usernames
      @handsByUsername[username] = new CardQueue()
      @orderByUsername[username] = order
      @ordering[order] = username

    deck = new Deck()
    deck.shuffle()
    while not deck.isEmpty()
      for username in @ordering
        @handsByUsername[username].push(deck.deal())
        if deck.isEmpty()
          break

  playCard: (username) =>
    if username != @ordering[@turn]
      return {success: false}
    card = @handsByUsername[username].pop()
    @pile.push(card)
    @turn = (@turn + 1) % @numPlayers

    console.log (username + " plays the " + card.toString())
    return {success: true, playedCard: card}

  slap: (username) =>
    console.log (username + " slaps")
    if @pile.isDouble() or @pile.isSandwich()
      console.log (username + " slaps correctly!")
      while not @pile.isEmpty()
        card = @pile.pop()
        @handsByUsername[username].push(card)
      @turn = @orderByUsername[username]
      return {success: true}
    else
      if @handsByUsername[username].isEmpty()
        return {success: false, burnedCard: null}
      card = @handsByUsername[username].pop()
      @pile.burnPush(card)

      console.log (username + " burns the " + card.toString())
      return {success: false, burnedCard: card}

module.exports = Game
