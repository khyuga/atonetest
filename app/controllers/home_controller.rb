class HomeController < ApplicationController
  protect_from_forgery

  include PokerHand
  include PokerError

  def top
  end

  def check # viewに送信するメソッド
    cards = params[:cards]
    flash[:cards] = "\"#{cards}\""
    flash[:messages] = PokerError.hand_validation(cards)&.join("\n") || PokerHand.judgement_result(cards)[0][:name]
    redirect_to("/")
  end

end
