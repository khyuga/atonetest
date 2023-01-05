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

    context '正常なカードの組み合わせが1つ送信されるケース' do
      let(:params){
        {
          "cards": [
            "C13 S12 C11 C10 C7"
          ]
        }
      }
      it_behaves_like 'httpリクエスト成功'
    end

  end
end
