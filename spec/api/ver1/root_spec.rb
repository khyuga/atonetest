require 'rails_helper'

RSpec.describe 'API', type: :request do
  include API::Ver1

  describe 'POST API' do
    before do
      post '/api/v1/poker', params, headers: { 'Content-Type' => 'application/json' }
    end

    shared_examples 'ステータスコード400とエラーメッセージが返される' do
      it 'ステータスコード400' do
        expect(response.status).to eq 400
      end

      it 'エラーメッセージ' do
        expect(JSON.parse(response.body)['error'][0]['msg']).to eq '正しい入力形式で送信してください。'
      end
    end

    context 'bodyが存在しないケース' do
      let(:params) {}

      it_behaves_like 'ステータスコード400とエラーメッセージが返される'
    end

    context 'ハッシュが存在しないケース' do
      let(:params) { {} }

      it_behaves_like 'ステータスコード400とエラーメッセージが返される'
    end

    context 'キーがcardsになっていないケース' do
      let(:params) { { card: [] } }

      it_behaves_like 'ステータスコード400とエラーメッセージが返される'
    end
  end

  describe 'GET API' do
    before do
      get '/api/v1/poker', headers: { 'Content-Type' => 'application/json' }
    end

    it 'ステータスコード400' do
      expect(response.status).to eq 400
    end

    it 'エラーメッセージ' do
      expect(JSON.parse(response.body)['error'][0]['msg']).to eq '正しい入力形式で送信してください。'
    end
  end

  describe 'File format is not JSON' do
    context 'Text' do
      before do
        post '/api/v1/poker', headers: { 'Content-Type' => 'text/plain' }
      end

      it 'ステータスコード400' do
        expect(response.status).to eq 400
      end

      it 'エラーメッセージ' do
        expect(JSON.parse(response.body)['error'][0]['msg']).to eq '正しい入力形式で送信してください。'
      end
    end

    context 'JavaScript' do
      before do
        post '/api/v1/poker', headers: { 'Content-Type' => 'application/javascript' }
      end

      it 'ステータスコード400' do
        expect(response.status).to eq 400
      end

      it 'エラーメッセージ' do
        expect(JSON.parse(response.body)['error'][0]['msg']).to eq '正しい入力形式で送信してください。'
      end
    end

    context 'HTML' do
      before do
        post '/api/v1/poker', headers: { 'Content-Type' => 'text/html' }
      end

      it 'ステータスコード400' do
        expect(response.status).to eq 400
      end

      it 'エラーメッセージ' do
        expect(JSON.parse(response.body)['error'][0]['msg']).to eq '正しい入力形式で送信してください。'
      end
    end

    context 'XML' do
      before do
        post '/api/v1/poker', headers: { 'Content-Type' => 'application/xml' }
      end

      it 'ステータスコード400' do
        expect(response.status).to eq 400
      end

      it 'エラーメッセージ' do
        expect(JSON.parse(response.body)['error'][0]['msg']).to eq '正しい入力形式で送信してください。'
      end
    end
  end
end
