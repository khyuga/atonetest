# 指定通りに入力されなかったカードがどのエラーに該当するかを判定
module PokerError
  # エラー内容を判定する
  def hand_validation(cards)
    if cards.blank?
      error_messages = ['カードを入力してください。']
    else
      cards_array = cards.split
      if cards_array.size != 5
        error_message = ['5つのカード指定文字を半角スペース区切りで入力してください。（例："S1 H3 D9 C13 S11"）']
      elsif incorrect_words(cards_array).present? && duplicate(cards_array).present?
        incorrect_words(cards_array) + duplicate(cards_array)
      else
        incorrect_words(cards_array) || duplicate(cards_array)
      end
    end
  end

  # 不正文字を含むケース
  def incorrect_words(cards_array)
    error_message = []
    correct_pairs = /^([CDHS])(1[0-3]|[1-9])$/
    cards_array.each.with_index do |card, i|
      error_message << "#{i + 1}番目のカード指定文字が不正です。（#{card}）" unless card.match(correct_pairs)
    end
    error_message if error_message != []
  end

  # 重複を含むケース
  def duplicate(cards_array)
    if cards_array.uniq.size != 5
      duplicate_cards = cards_array.select { |v| cards_array.count(v) > 1 }.uniq
      error_message = ["カードが重複しています。（#{duplicate_cards.join(', ')}）"]
    end
  end

  module_function :hand_validation, :incorrect_words, :duplicate
end
