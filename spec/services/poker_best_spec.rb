require 'rails_helper'

include PokerBest

RSpec.describe PokerBest do
  describe '強弱判定' do
    let(:judge){ PokerBest.best_hand(result) }
    #binding.pry
    context '正常なカードの組み合わせが3つ送信されるケース' do
      let(:result){
        [
          {:cards=>"H9 S9 D11 H11 H10", :hand=>"ツーペア", :best=>2},
          {:cards=>"H9 S3 D10 H2 S2", :hand=>"ワンペア", :best=>1},
          {:cards=>"C13 S12 C11 C10 C7", :hand=>"ハイカード", :best=>0}
        ]
      }
      it 'bestの値が一番大きい組み合わせ' do
        expect(judge[0][:best]).to eq true
      end
    end
  end
end
