 module Ver1
    class Cards < Grape::API
      content_type :json, 'application/json'
      format :json

      include PokerHand
      include PokerError
      include PokerBest

      params do
        requires :cards, type: Array
      end

      resource :poker do
        post do
          #status 200
          cards_array = params[:cards]
          irregular_cards = cards_array.select{ |cards| PokerError.hand_validation(cards)}
          regular_cards = cards_array - irregular_cards
          error = irregular_cards.map do |cards|
            if PokerError.hand_validation(cards)
              {
                cards: cards,
                msg: PokerError.hand_validation(cards).join(',')
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
              #Rails.logger.info PokerHand.judgement_result(cards)[0]
            end
          end
          PokerBest.best_hand(result)
          if result.blank?
            output = {error: error}
          elsif error.blank?
            output = {result: result}
          else
            output = {result: result, error: error}
          end
        end
      end

    end
 end
