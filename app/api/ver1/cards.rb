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
        hands = params[:cards]
        PokerAPI.api_output(hands)
      end
    end
  end
end
