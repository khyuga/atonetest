class HomeController < ApplicationController
  protect_from_forgery

  def top; end

  # WebAppで入力されたカードとその判定結果をviewにリダイレクトする
  def check
    hand = params[:cards]
    flash[:cards] = "\"#{hand}\""
    flash[:errors] = PokerError.hand_validation(hand)&.join("\n")
    flash[:result] = PokerHand.category(hand)[:name] if flash[:errors].blank?
    redirect_to('/')
  end
end
