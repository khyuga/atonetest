require 'rails_helper'

RSpec.describe PokerHand do
  include PokerHand
  describe '役判定' do
    let(:hand) { PokerHand.judgement_result(cards)[0] }
    subject { hand }

    shared_examples 'ストレートフラッシュ' do
      it { is_expected.to eq({ name: 'ストレートフラッシュ', score: 8 }) }
    end
    context '同じスートのカードが5枚で数字が連続するケース' do
      let(:cards) { 'S1 S3 S5 S2 S4' }
      it_behaves_like 'ストレートフラッシュ'
    end
    context '同じスートのカードが5枚で昇順の数字が1,10,11,12,13のケース' do
      let(:cards) { 'H1 H11 H13 H12 H10' }
      it_behaves_like 'ストレートフラッシュ'
    end

    context '同じ数字のカードが4枚あるケース' do
      let(:cards) { 'S1 C1 D1 H10 H1' }
      it { is_expected.to eq({ name: 'フォーカード', score: 7 }) }
    end

    context '同じ数字のカード3枚と別の同じ数字のカード2枚のケース' do
      let(:cards) { 'S10 C2 D10 H2 H10' }
      it { is_expected.to eq({ name: 'フルハウス', score: 6 }) }
    end

    context '同じスートのカード5枚が数字が連続しないケース' do
      let(:cards) { 'H1 H12 H10 H5 H3' }
      it { is_expected.to eq({ name: 'フラッシュ', score: 5 }) }
    end

    context '数字が連続した5枚のカードでスートが全て同じではないケース' do
      let(:cards) { 'S8 S7 H6 H5 S4' }
      it { is_expected.to eq({ name: 'ストレート', score: 4 }) }
    end

    context '同じ数字のカード3枚と数字の違う2枚のケース' do
      let(:cards) { 'C5 H5 D5 D12 C10' }
      it { is_expected.to eq({ name: 'スリーカード', score: 3 }) }
    end

    context '同じ数字のカード2枚組が2組と他のカード1枚のケース' do
      let(:cards) { 'H13 D13 C2 D2 H11' }
      it { is_expected.to eq({ name: 'ツーペア', score: 2 }) }
    end

    context '同じ数字のカード2枚組とそれぞれ異なった数字のカード3枚のケース' do
      let(:cards) { 'H9 C9 H1 D12 D10' }
      it { is_expected.to eq({ name: 'ワンペア', score: 1 }) }
    end

    context '上述の役が1つも成立しないケース' do
      let(:cards) { 'D1 D10 S9 C5 C4' }
      it { is_expected.to eq({ name: 'ハイカード', score: 0 }) }
    end
  end
end
