class HomeController < ApplicationController
  protect_from_forgery

  include PokerHand
  include PokerError

  def top; end

  # WebAppで入力されたカードとその判定結果をviewにリダイレクトする
  def check
    cards = params[:cards]
    flash[:cards] = "\"#{cards}\""
    flash[:errors] = PokerError.hand_validation(cards)&.join("\n")
    flash[:result] = PokerHand.judgement_result(cards)[:name] if flash[:errors].blank?
    redirect_to('/')
  end
end
