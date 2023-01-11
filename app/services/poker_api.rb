module PokerAPI

  include PokerHand
  include PokerError
  include PokerBest

  def api_output(cards_array)
    irregular_cards = cards_array.select{ |cards| PokerError.hand_validation(cards)}
    regular_cards = cards_array - irregular_cards

    error = irregular_cards.map do |cards|
      if PokerError.hand_validation(cards)
        {
          cards: cards,
          msg: PokerError.hand_validation(cards).join("\n")
        }
      end
    end

    result = regular_cards.map do |cards|
      if PokerHand.judgement_result(cards)
        {
          cards: cards,
          hand: PokerHand.judgement_result(cards)[0][:name],
          best: PokerHand.judgement_result(cards)[0][:score]
        }
      end
    end
    result = PokerBest.best_hand(result)

    if result.blank?
      output = {error: error}
    elsif error.blank?
      output = {result: result}
    else
      output = {result: result, error: error}
    end

  end

  module_function :api_output
end
