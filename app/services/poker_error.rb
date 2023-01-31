# 指定通りに入力されなかったカードがどのエラーに該当するかを判定
module PokerError
  # エラー内容を判定する
  def hand_validation(hand)
    if hand.blank?
      error_messages = ['カードを入力してください。']
    else
      cards = hand.split
      if cards.size != 5
        error_messages = ['5つのカード指定文字を半角スペース区切りで入力してください。（例："S1 H3 D9 C13 S11"）']
      elsif incorrect_words(cards).present? && duplicate(cards).present?
        error_messages = []
        error_messages << incorrect_words(cards)
        error_messages << duplicate(cards)
        error_messages.flatten
      else
        incorrect_words(cards) || duplicate(cards)
      end
    end
  end

  # 不正文字を含むケース
  def incorrect_words(cards)
    error_messages = []
    correct_pairs = /^([CDHS])(1[0-3]|[1-9])$/
    cards.map.with_index do |card, i|
      error_messages << "#{i + 1}番目のカード指定文字が不正です。（#{card}）" unless card.match(correct_pairs)
    end
    error_messages.presence
  end

  # 重複を含むケース
  def duplicate(cards)
    if cards.uniq.size != 5
      duplicate_cards = cards.select { |v| cards.count(v) > 1 }.uniq
      error_messages = ["カードが重複しています。（#{duplicate_cards.join(', ')}）"]
    end
  end

  module_function :hand_validation, :incorrect_words, :duplicate
end
