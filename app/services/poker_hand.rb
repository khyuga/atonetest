# 指定通りに入力されたカードがどの役に該当するかを判定
module PokerHand
  HAND_LIST = {
    straight_flush: { name: 'ストレートフラッシュ', score: 8 },
    four_card: { name: 'フォーカード', score: 7 },
    full_house: { name: 'フルハウス', score: 6 },
    flush: { name: 'フラッシュ', score: 5 },
    straight: { name: 'ストレート', score: 4 },
    three_card: { name: 'スリーカード', score: 3 },
    two_pair: { name: 'ツーペア', score: 2 },
    one_pair: { name: 'ワンペア', score: 1 },
    high_card: { name: 'ハイカード', score: 0 }
  }.freeze

  # 役判定メソッド
  def judgement_result(cards)
    result_array = HAND_LIST.keys.map do |hand|
      send(hand, cards)
    end
    result = result_array.compact
  end

  def suit_array(cards)
    cards.scan(/[CDHS]/)
  end

  def number_array(cards)
    cards.scan(/1[0-3]|[1-9]/).map(&:to_i)
  end

  def number_duplicate_counts(cards)
    num_array = number_array(cards)
    num_array.uniq.map { |e| num_array.count(e) }.sort
  end

  def straight_flush(cards)
    HAND_LIST[:straight_flush] if straight(cards) && flush(cards)
  end

  def straight(cards)
    num_array = number_array(cards)
    if (num_array.max - num_array.min == 4 && num_array.uniq.size == 5) || num_array.sort == [1, 10, 11, 12, 13]
      HAND_LIST[:straight]
    end
  end

  def flush(cards)
    HAND_LIST[:flush] if suit_array(cards).uniq.size == 1
  end

  def four_card(cards)
    HAND_LIST[:four_card] if number_duplicate_counts(cards) == [1, 4]
  end

  def full_house(cards)
    HAND_LIST[:full_house] if number_duplicate_counts(cards) == [2, 3]
  end

  def three_card(cards)
    HAND_LIST[:three_card] if number_duplicate_counts(cards) == [1, 1, 3]
  end

  def two_pair(cards)
    HAND_LIST[:two_pair] if number_duplicate_counts(cards) == [1, 2, 2]
  end

  def one_pair(cards)
    HAND_LIST[:one_pair] if number_duplicate_counts(cards) == [1, 1, 1, 2]
  end

  def high_card(_cards)
    HAND_LIST[:high_card]
  end

  module_function :judgement_result,
                  :suit_array,
                  :number_array,
                  :number_duplicate_counts,
                  :straight_flush,
                  :flush,
                  :straight,
                  :four_card,
                  :full_house,
                  :three_card,
                  :two_pair,
                  :one_pair,
                  :high_card
end
