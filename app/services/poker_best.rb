module PokerBest

  def best_hand(result)
    score_array = result.map{ |score| score[:best] }
    score_array.map.with_index { |score, i|
      result[i][:best] = (result[i][:best] == score_array.max)
    }
    result
  end

  module_function :best_hand
end
