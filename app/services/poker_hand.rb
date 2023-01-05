module PokerHand
  HAND_LIST = {
    straight_flush: { name: "ストレートフラッシュ", score: 8 },
    four_card: { name: "フォーカード", score: 7 },
    full_house: { name: "フルハウス", score: 6 },
    flush: { name: "フラッシュ", score: 5 },
    straight: { name: "ストレート", score: 4 },
    three_card: { name: "スリーカード", score: 3 },
    two_pair: { name: "ツーペア", score: 2 },
    one_pair: { name: "ワンペア", score: 1 },
    high_card: { name: "ハイカード", score: 0 }
  }.freeze

  def judgement_result(cards) # 役判定メソッド
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
    num_array.uniq.map{ |e| num_array.count(e) }.sort
  end

  def straight_flush(cards)
    if straight(cards) && flush(cards)
      HAND_LIST[:straight_flush]
    end
  end

  def straight(cards)
    num_array = number_array(cards)
    if (num_array.max - num_array.min == 4 && num_array.uniq.size == 5) || num_array.sort == [1,10,11,12,13]
      HAND_LIST[:straight]
    end
  end

  def flush(cards)
    if suit_array(cards).uniq.size == 1
      HAND_LIST[:flush]
    end
  end

  def four_card(cards)
    if number_duplicate_counts(cards) == [1, 4]
      HAND_LIST[:four_card]
    end
  end

  def full_house(cards)
    if number_duplicate_counts(cards) == [2, 3]
      HAND_LIST[:full_house]
    end
  end

  def three_card(cards)
    if number_duplicate_counts(cards) == [1, 1, 3]
      HAND_LIST[:three_card]
    end
  end

  def two_pair(cards)
    if number_duplicate_counts(cards) == [1, 2, 2]
      HAND_LIST[:two_pair]
    end
  end

  def one_pair(cards)
    if number_duplicate_counts(cards) == [1, 1, 1, 2]
      HAND_LIST[:one_pair]
    end
  end

  def high_card(cards)
    HAND_LIST[:high_card]
  end

  module_function :judgement_result, :suit_array, :number_array, :number_duplicate_counts, :straight_flush, :flush, :straight, :four_card, :full_house, :three_card, :two_pair, :one_pair, :high_card
end
