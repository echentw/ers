Suit = require('./suit')

class Card

  constructor: (value, suit) ->
    @value = value
    @suit = suit

  getValue: =>
    return @value

  getValueString: =>
    switch @value
      when 1 then return "ace"
      when 11 then return "jack"
      when 12 then return "queen"
      when 13 then return "king"
      else return "" + @value

  getSuit: =>
    return @suit

  getSuitString: =>
    switch @suit
      when Suit.CLUBS then return "clubs"
      when Suit.DIAMONDS then return "diamonds"
      when Suit.HEARTS then return "hearts"
      when Suit.SPADES then return "spades"
      else return "HELP ERROR!!!"

  toString: =>
    return (@getValueString() + " of " + @getSuitString())

module.exports = Card
