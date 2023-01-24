require 'rails_helper'

include API::Ver1

RSpec.describe 'API', type: :request do
  before do
    post '/api/v1/poker', params
  end

  shared_examples 'ステータスコード201' do
    it '201 created' do
      expect(response.status).to eq 201
    end
  end

  describe '正常系' do

    context '正常なカードの組み合わせが1つ送信されるケース' do
      let(:params) do
        {
          cards: [
            'C13 S12 C11 C10 C7'
          ]
        }
      end

      it_behaves_like 'ステータスコード201'
    end

    context '正常なカードの組み合わせが2つ以上送信されるケース' do
      let(:params) do
        {
          cards: [
            'C13 S12 C11 C10 C7',
            'H9 C9 S9 H2 C2',
            'H9 S9 D11 H11 H10'
          ]
        }
      end

      it_behaves_like 'ステータスコード201'
    end
  end

  describe '純正常系' do

    context '不正カードを1つ含む組み合わせが送信されるケース' do
      let(:params) do
        {
          cards: [
            'H9 C9 S9 H2 C22'
          ]
        }
      end

      it_behaves_like 'ステータスコード201'
    end

    context '不正カードを複数含む組み合わせが送信されるケース' do
      let(:params) do
        {
          cards: [
            'H9 C9 S9 H22 C22'
          ]
        }
      end

      it_behaves_like 'ステータスコード201'
    end

    context '不正カード、重複、枚数違反を含む組み合わせ、及び未入力が送信されるケース' do
      let(:params) do
        {
          cards: [
            'H9 C9 S9 H22 C2',
            'H1 H13 W12 H11 H11',
            'C13 D12 C11 H8',
            ''
          ]
        }
      end

      it_behaves_like 'ステータスコード201'
    end

    context '正常な組み合わせとエラーを含む組み合わせが同時に送信されるケース' do
      let(:params) do
        {
          cards: [
            'H1 H13 H12 H11 H11',
            'H9 S9 D11 H11 H10',
            'C13 D12 C11 H8 H7 H10',
            'H9 C9 S9 H2 C2'
          ]
        }
      end

      it_behaves_like 'ステータスコード201'
    end
  end
end
