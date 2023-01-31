# 最も強い役に該当するカード組を判定
module PokerBest
  def best_hand(result)
    scores = result.map { |res| res[:score] }
    result.map.with_index do |res, i|
      res[:best] = (result[i][:score] == scores.max)
      res.delete(:score)
    end
    result
  end

  module_function :best_hand
end
