 module Ver1
    class Cards < Grape::API
      content_type :json, 'application/json'
      format :json

      include PokerAPI

      params do
        requires :cards, type: Array
      end

      resource :poker do
        post do
          cards_array = params[:cards]
          PokerAPI.api_output(cards_array)
        end
      end

    end
 end
