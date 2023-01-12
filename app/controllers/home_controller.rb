class HomeController < ApplicationController
  protect_from_forgery

  include PokerHand
  include PokerError

  def top; end

  # WebAppで入力されたカードとその判定結果をviewにリダイレクトする
  def check
    cards = params[:cards]
    flash[:cards] = "\"#{cards}\""
    flash[:messages] = PokerError.hand_validation(cards)&.join("\n") || PokerHand.judgement_result(cards)[0][:name]
    redirect_to('/')
  end
end
