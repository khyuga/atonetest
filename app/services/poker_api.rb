module PokerAPI
  include PokerHand
  include PokerError
  include PokerBest

  def api_output(cards_array)
    irregular_cards = cards_array.select { |cards| PokerError.hand_validation(cards)&.any? }
    regular_cards = cards_array - irregular_cards

    error = irregular_cards.map do |cards|
      if PokerError.hand_validation(cards)[1]
        {
          cards: cards,
          msg: PokerError.hand_validation(cards)
        }
      else
        {
          cards: cards,
          msg: PokerError.hand_validation(cards)[0]
        }
      end
    end

    result = regular_cards.map do |cards|
      {
        cards: cards,
        hand: PokerHand.judgement_result(cards)[0][:name],
        best: PokerHand.judgement_result(cards)[0][:score]
      }
    end
    result = PokerBest.best_hand(result)

    output = if result.blank?
               { error: error }
             elsif error.blank?
               { result: result }
             else
               { result: result, error: error }
             end
  end

  module_function :api_output
end
