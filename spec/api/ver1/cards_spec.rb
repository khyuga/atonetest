require 'rails_helper'

include Ver1

RSpec.describe 'API', type: :request do
  describe '正常系' do
    let(:url) { '/api/v1/poker' }
    let(:params) do
      {
        "cards": [
          'C13 S12 C11 C10 C7'
        ]
      }
    end
    it '正常なカードの組み合わせが1つ送信されるケース' do
      post url, params
      expect(response).to have_http_status 201
    end
  end
end
