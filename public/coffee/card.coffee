define([], ->

  class Card
    constructor: (value, suit) ->
      @value = value
      @suit = suit

    getValueString: =>
      switch @value
        when 1 then return "ace"
        when 11 then return "jack"
        when 12 then return "queen"
        when 13 then return "king"
        else return "" + @value

    getSuitString: =>
      switch @suit
        when 0 then return "clubs"
        when 1 then return "diamonds"
        when 2 then return "hearts"
        when 3 then return "spades"
        else return "HELP ERROR!!!"

  return Card
)
