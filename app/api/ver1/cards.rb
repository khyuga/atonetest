module Ver1
  class Cards < Grape::API
    content_type :json, 'application/json'
    format :json

    desc "複数のカード組を入力し、ポーカーの役と勝敗を判定して返します。"
    params do
      requires :cards, type: Array, desc: '入力例：{"cards": ["D1 D13 D12 D11 D10","H9 C9 S9 H2 C2"]}'
    end

    resource :poker do
      post do
        hands = params[:cards]
        Services::PokerAPI.api_output(hands)
      end
    end

  end
end
