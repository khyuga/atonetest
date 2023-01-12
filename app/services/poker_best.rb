module PokerBest
  def best_hand(result)
    score_array = result.map { |score| score[:best] }
    score_array.map.with_index do |_score, i|
      result[i][:best] = (result[i][:best] == score_array.max)
    end
    result
  end

  module_function :best_hand
end
