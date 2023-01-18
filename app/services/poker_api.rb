# APIの出力面を作成
module PokerAPI

  def api_output(hands)
    invalid_hands = hands.select { |hand| PokerError.hand_validation(hand)&.any? }
    valid_hands = hands - invalid_hands

    error = invalid_hands.map do |hand|
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

    result = valid_hands.map do |hand|
      {
        cards: hand,
        hand: PokerHand.category(hand)[:name],
        best: PokerHand.category(hand)[:score]
      }
    end
    result = PokerBest.best_hand(result)

    { result: result, error: error }.transform_values(&:presence).compact
  end

  module_function :api_output
end
