# APIの出力面を作成
module PokerAPI

  def api_output(hands)
    irregular_cards = hands.select { |hand| PokerError.hand_validation(hand)&.any? }
    regular_cards = hands - irregular_cards

    error = irregular_cards.map do |hand|
      if PokerError.hand_validation(hand)[1]
        {
          cards: hand,
          msg: PokerError.hand_validation(hand)
        }
      else
        {
          cards: hand,
          msg: PokerError.hand_validation(hand)[0]
        }
      end
    end

    result = regular_cards.map do |hand|
      {
        cards: hand,
        hand: PokerHand.judgement_result(hand)[:name],
        best: PokerHand.judgement_result(hand)[:score]
      }
    end
    result = PokerBest.best_hand(result)

    { result: result, error: error }.transform_values(&:presence).compact
  end

  module_function :api_output
end
