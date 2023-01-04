require 'rails_helper'

include PokerHand
include PokerError

RSpec.describe HomeController, type: :controller do
  describe "top" do
    it 'トップページの応答が正常' do
      get :top
      expect(response).to be_success
    end
    it 'ブラウザの要求がサーバーに正しく受け取られる' do
      get :top
      expect(response).to have_http_status "200"
    end
  end

  describe 'check' do
    it 'viewにリダイレクト' do
      post :check
      expect(response).to redirect_to "/"
    end
  end

end
