Suit = require('./suit')

class Card

  constructor: (value, suit) ->
    @value = value
    @suit = suit

  getValue: =>
    return @value

  getSuit: =>
    return @suit

  toString: =>
    value
    switch @value
      when 1 then value = "ace"
      when 11 then value = "jack"
      when 12 then value = "queen"
      when 13 then value = "king"
      else value = @value

    suit
    switch @suit
      when Suit.CLUBS then suit = "clubs"
      when Suit.DIAMONDS then suit = "diamonds"
      when Suit.HEARTS then suit = "hearts"
      when Suit.SPADES then suit = "spades"
      else suit = "WHAAAAAAAAAAAAAAAAAAAAAAAAAAT"

    return (value + " of " + suit)

module.exports = Card
