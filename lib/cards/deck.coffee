Suit = require('./suit')
Card = require('./card')

class Deck

  constructor: ->
    @cards = []
    for suit in Suit.SUITS
      for value in [1...13 + 1]
        @cards.push(new Card(value, suit))

  shuffle: =>
    for i in [52 ... 0] by -1
      j = Math.floor(Math.random() * i)
      temp = @cards[i - 1]
      @cards[i - 1] = @cards[j]
      @cards[j] = temp

  deal: =>
    return @cards.pop()

  isEmpty: =>
    return not @cards.length

module.exports = Deck
