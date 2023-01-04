require 'rails_helper'

include Ver1

RSpec.describe 'API', type: :request do
  describe '正常系' do
    before do
      post '/api/v1/poker', params
    end
    shared_examples 'httpリクエスト成功' do
      it { is_expect(response.status).to eq 201}
    end
    let(:result){ PokerBest.best_hand(result) }
    let(:error){ Ver1.error }

    context '役のある組み合わせが1つ送信されるケース' do
      let(:params){
        {
          "cards": [
            "H9 S9 D11 H11 H10"
          ]
        }
      }
      it '該当する役が返される' do
        expect(result[:cards]).to eq("ツーペア")
      end
    end

    #let(:params){
    # {
    #   "cards": [
    #     "H9 S9 D11 H11 H10",
    #     "H9 S3 D10 H2 S2",
    #     "C13 S12 C11 C10 C7"
    #   ]
    # }
    #}
  end
end
