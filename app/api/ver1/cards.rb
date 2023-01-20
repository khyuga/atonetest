module API
  module Ver1
    class Cards < Grape::API
      content_type :json, 'application/json'
      format :json

      include API::Services::PokerAPI

      params do
        requires :cards, type: Array
      end

      resource :poker do
        post do
          hands = params[:cards]
          API::Services::PokerAPI.api_output(hands)
        end
      end

    end
  end
end
