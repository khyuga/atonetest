# 指定通りに入力されたカードがどの役に該当するかを判定
module PokerHand
  HAND_LIST = {
    straight_flush?: { name: 'ストレートフラッシュ', score: 8 },
    four_card?: { name: 'フォーカード', score: 7 },
    full_house?: { name: 'フルハウス', score: 6 },
    flush?: { name: 'フラッシュ', score: 5 },
    straight?: { name: 'ストレート', score: 4 },
    three_card?: { name: 'スリーカード', score: 3 },
    two_pair?: { name: 'ツーペア', score: 2 },
    one_pair?: { name: 'ワンペア', score: 1 },
    high_card?: { name: 'ハイカード', score: 0 }
  }.freeze

  # 役判定メソッド
  def judgement_result(cards)
    hand_list_keys = HAND_LIST.keys.detect{ |x| send(x, cards) }
    HAND_LIST[hand_list_keys]
  end

  def suit(cards)
    cards.scan(/[CDHS]/)
  end

  def number(cards)
    cards.scan(/1[0-3]|[1-9]/).map(&:to_i)
  end

  def number_duplicate_counts(cards)
    number(cards).uniq.map { |e| number(cards).count(e) }.sort
  end

  def straight_flush?(cards)
    straight?(cards) && flush?(cards)
  end

  def straight?(cards)
    (number(cards).max - number(cards).min == 4 && number(cards).uniq.size == 5) || number(cards).sort == [1, 10, 11, 12, 13]
  end

  def flush?(cards)
    suit(cards).uniq.size == 1
  end

  def four_card?(cards)
    number_duplicate_counts(cards) == [1, 4]
  end

  def full_house?(cards)
    number_duplicate_counts(cards) == [2, 3]
  end

  def three_card?(cards)
    number_duplicate_counts(cards) == [1, 1, 3]
  end

  def two_pair?(cards)
    number_duplicate_counts(cards) == [1, 2, 2]
  end

  def one_pair?(cards)
    number_duplicate_counts(cards) == [1, 1, 1, 2]
  end

  def high_card?(cards)
    number_duplicate_counts(cards) == [1, 1, 1, 1, 1] && ( [straight?(cards)] || [flush?(cards)] == false )
  end

  module_function :judgement_result
end
