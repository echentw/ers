class CardQueue

  constructor: ->
    @cards = []

  push: (card) =>
    @cards.push(card)

  pop: =>
    return @cards.shift()

  length: =>
    return @cards.length

  isEmpty: =>
    return not @cards.length

  burnPush: (card) =>
    @cards.unshift(card)

  isDouble: =>
    if @cards.length < 2
      return false

    id1 = @cards.length - 1
    id2 = @cards.length - 2

    console.log @cards[id1].toString() + ', ' + @cards[id2].toString()
    return @cards[id1].getValue() == @cards[id2].getValue()

  isSandwich: =>
    if @cards.length < 3
      return false

    id1 = @cards.length - 1
    id2 = @cards.length - 3

    console.log @cards[id1].toString() + ', ' + @cards[id2].toString()
    return @cards[id1].getValue() == @cards[id2].getValue()

module.exports = CardQueue
