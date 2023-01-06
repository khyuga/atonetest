module PokerError

  def hand_validation(cards)
    if cards.blank?
      error_messages = ["カードを入力してください。"]
    else
      cards_array = cards.split
      lack_of_cards(cards_array) || incorrect_words(cards_array) || duplicate(cards_array)
    end
  end

  def lack_of_cards(cards_array) #フォームは空白でないが枚数が5枚でないケース
    if cards_array.size != 5
      error_message = ["5つのカード指定文字を半角スペース区切りで入力してください。（例：\"S1 H3 D9 C13 S11\"）"]
    end
  end

  def incorrect_words(cards_array) #枚数5枚だが不正文字を含むケース
    error_message = []
    correct_pairs = /^([CDHS])(1[0-3]|[1-9])$/
    cards_array.map.with_index{ |card, i|
      if !card.match(correct_pairs)
        error_message << "#{i+1}番目のカード指定文字が不正です。（#{card}）"
      end
    }
    if error_message != []
      error_message
    end
  end

  def duplicate(cards_array) #枚数5枚で不正文字もないが重複を含むケース
    if cards_array.uniq.size != 5
      duplicate_cards = cards_array.select{|v| cards_array.count(v) > 1}.uniq
      error_message = ["カードが重複しています。（#{duplicate_cards.join(', ')}）"]
    end
  end

  module_function :hand_validation, :lack_of_cards, :incorrect_words, :duplicate

end
