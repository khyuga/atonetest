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
  def judgement_result(hand)
    hand_list_keys = HAND_LIST.keys.detect{ |x| send(x, hand) }
    HAND_LIST[hand_list_keys]
  end

  def suit(hand)
    hand.scan(/[CDHS]/)
  end

  def number(hand)
    hand.scan(/1[0-3]|[1-9]/).map(&:to_i)
  end

  def number_duplicate_counts(hand)
    number(hand).uniq.map { |e| number(hand).count(e) }.sort
  end

  def straight_flush?(hand)
    straight?(hand) && flush?(hand)
  end

  def straight?(hand)
    (number(hand).max - number(hand).min == 4 && number(hand).uniq.size == 5) || number(hand).sort == [1, 10, 11, 12, 13]
  end

  def flush?(hand)
    suit(hand).uniq.size == 1
  end

  def four_card?(hand)
    number_duplicate_counts(hand) == [1, 4]
  end

  def full_house?(hand)
    number_duplicate_counts(hand) == [2, 3]
  end

  def three_card?(hand)
    number_duplicate_counts(hand) == [1, 1, 3]
  end

  def two_pair?(hand)
    number_duplicate_counts(hand) == [1, 2, 2]
  end

  def one_pair?(hand)
    number_duplicate_counts(hand) == [1, 1, 1, 2]
  end

  def high_card?(hand)
    number_duplicate_counts(hand) == [1, 1, 1, 1, 1] && ( [straight?(hand)] || [flush?(hand)] == false )
  end

  module_function :judgement_result,
                  :suit,
                  :number,
                  :number_duplicate_counts,
                  :straight_flush?,
                  :flush?,
                  :straight?,
                  :four_card?,
                  :full_house?,
                  :three_card?,
                  :two_pair?,
                  :one_pair?,
                  :high_card?
end
