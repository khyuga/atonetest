require 'rails_helper'

RSpec.describe 'API', type: :request do
  include Ver1

  describe "POST API" do
    before do
      post "/api/v1/poker", params
    end

    shared_examples "ステータスコード400とエラーメッセージが返される" do
      it "ステータスコード400" do
        expect(response.status).to eq 400
      end
      it "エラーメッセージ" do
        expect(JSON.parse(response.body)["error"][0]["msg"]).to eq "正しい入力形式で送信してください。"
      end
    end

    context "bodyが存在しないケース" do
      let(:params){  }
      it_behaves_like "ステータスコード400とエラーメッセージが返される"
    end

    context "ハッシュが存在しないケース" do
      let(:params){ {  } }
      it_behaves_like "ステータスコード400とエラーメッセージが返される"
    end

    context "キーがcardsになっていないケース" do
      let(:params){ { "card": [] } }
      it_behaves_like "ステータスコード400とエラーメッセージが返される"
    end

  end

  describe "GET API" do
    before do
      get "/api/v1/poker"
    end

    it "ステータスコード400" do
      expect(response.status).to eq 400
    end
    it "エラーメッセージ" do
      expect(JSON.parse(response.body)["error"][0]["msg"]).to eq "正しい入力形式で送信してください。"
    end
  end
end
