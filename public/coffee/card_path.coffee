define([], ->

  class CardPath
    this.BASE_URL = '/img/SVG-cards-1.3/'

    @getCardPath: (card) ->
      return this.BASE_URL + card.getValueString() + '_of_' + card.getSuitString() + '.svg'

  return CardPath
)
