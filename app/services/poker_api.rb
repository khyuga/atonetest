# APIの出力面を作成
module PokerAPI

  def api_output(hands)
    irregular_cards = hands.select { |cards| PokerError.hand_validation(cards)&.any? }
    regular_cards = hands - irregular_cards

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
        hand: PokerHand.judgement_result(cards)[:name],
        best: PokerHand.judgement_result(cards)[:score]
      }
    end
    result = PokerBest.best_hand(result)

    { result: result, error: error }.transform_values(&:presence).compact
  end

  module_function :api_output
end
