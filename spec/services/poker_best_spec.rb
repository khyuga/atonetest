require 'rails_helper'

include PokerBest

RSpec.describe PokerBest do
  describe '強弱判定' do
    let(:judge) { PokerBest.best_hand(result) }
    context '正常なカードの組み合わせが1つ送信されるケース' do
      let(:result) do
        [
          { cards: 'C13 S12 C11 C10 C7', hand: 'ハイカード', best: 0 }
        ]
      end
      it '1つ目の組み合わせのbestはtrue' do
        expect(judge[0][:best]).to eq true
      end
    end

    context '正常なカードの組み合わせが2つ以上送信されるケース' do
      let(:result) do
        [
          { cards: 'H9 S9 D11 H11 H10', hand: 'ツーペア', best: 2 },
          { cards: 'H9 S3 D10 H2 S2', hand: 'ワンペア', best: 1 },
          { cards: 'C13 S12 C11 C10 C7', hand: 'ハイカード', best: 0 }
        ]
      end
      it '1つ目の組み合わせのbestはtrue' do
        expect(judge[0][:best]).to eq true
      end
      it '2つ目の組み合わせのbestはfalse' do
        expect(judge[1][:best]).to eq false
      end
      it '3つ目の組み合わせのbestはfalse' do
        expect(judge[2][:best]).to eq false
      end
    end

    context 'bestに同率一位が存在するケース' do
      let(:result) do
        [
          { cards: 'H9 S9 D11 H11 H10', hand: 'ツーペア', best: 2 },
          { cards: 'H9 S3 D3 H2 S2', hand: 'ツーペア', best: 2 }
        ]
      end
      it '1つ目の組み合わせのbestはtrue' do
        expect(judge[0][:best]).to eq true
      end
      it '2つ目の組み合わせのbestもtrue' do
        expect(judge[1][:best]).to eq true
      end
    end
  end
end
