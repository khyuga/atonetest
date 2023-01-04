class HomeController < ApplicationController
  protect_from_forgery

  include PokerHand
  include PokerError

  def top
  end

  def check # viewに送信するメソッド
    cards = params[:cards]
    flash[:messages] = PokerError.hand_validation(cards)&.join("\n") || PokerHand.judgement_result(cards)[0][:name]
    #binding.pry
    if flash[:messages].include?("不正")
      flash[:messages] += "\n半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。"
    end
    redirect_to("/")
  end

end
