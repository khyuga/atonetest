class HomeController < ApplicationController
  protect_from_forgery

  include PokerHand
  include PokerError

  def top; end

  # WebAppで入力されたカードとその判定結果をviewにリダイレクトする
  def check
    hand = params[:cards]
    flash[:hand] = "\"#{hand}\""
    flash[:errors] = PokerError.hand_validation(hand)&.join("\n")
    flash[:result] = PokerHand.judgement_result(hand)[:name] if flash[:errors].blank?
    redirect_to('/')
  end
end
