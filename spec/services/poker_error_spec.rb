require 'rails_helper'

include PokerError

RSpec.describe PokerError do
  describe 'エラー判定' do
    let(:msg){ PokerError.hand_validation(cards) }
    subject{msg}

    context 'フォームが空白のケース'
      let(:cards){ "" }
      it { expect(msg).to eq ["手札のカード枚数が足りません。正しく手札を入力してください"] }

    shared_examples 'カードが5枚半角スペース区切りになってない' do
      it { is_expected.to eq ["5つのカード指定文字を半角スペース区切りで入力してください。（例：\"S1 H3 D9 C13 S11\"）"] }
    end
    context 'フォームが空白ではないが5枚以下のケース' do
      let(:cards){ "S1 S2 S3 S4"}
      it_behaves_like 'カードが5枚半角スペース区切りになってない'
    end
    context 'カードが5枚以上あるケース' do
      let(:cards){ "S1 S2 S3 S4 S5 S6" }
      it_behaves_like 'カードが5枚半角スペース区切りになってない'
    end
    context '区切りに全角スペースが含まれているケース' do
      let(:cards){ "S1 S2 S3　S4 S5" }
      it_behaves_like 'カードが5枚半角スペース区切りになってない'
    end

    context 'カードは5枚だがスートに1つ不正文字が含まれているケース' do
      let(:cards){ "S1 S2 s3 S4 S5" }
      it { expect(msg).to eq ["3番目のカード指定文字が不正です。（s3）"] }
    end
    context 'カードは5枚だがスートに複数不正文字が含まれているケース' do
      let(:cards){ "Q1 S2 s3 S4 #5" }
      it { expect(msg).to eq ["1番目のカード指定文字が不正です。（Q1）", "3番目のカード指定文字が不正です。（s3）", "5番目のカード指定文字が不正です。（#5）"] }
    end
    context 'カードは5枚だがスート全てに不正文字が含まれているケース' do
      let(:cards){ "Q1 @2 s3 04 #5" }
      it { expect(msg).to eq ["1番目のカード指定文字が不正です。（Q1）", "2番目のカード指定文字が不正です。（@2）", "3番目のカード指定文字が不正です。（s3）", "4番目のカード指定文字が不正です。（04）", "5番目のカード指定文字が不正です。（#5）"] }
    end
    context 'カードは5枚だが数字に1つ不正文字が含まれているケース' do
      let(:cards){ "S1 S2 S14 S4 S5" }
      it { expect(msg).to eq ["3番目のカード指定文字が不正です。（S14）"] }
    end
    context 'カードは5枚だが数字に複数不正文字が含まれているケース' do
      let(:cards){ "S0 S2 S14 S4 S5-2" }
      it { expect(msg).to eq ["1番目のカード指定文字が不正です。（S0）", "3番目のカード指定文字が不正です。（S14）", "5番目のカード指定文字が不正です。（S5-2）"] }
    end
    context 'カードは5枚だがスート全てに不正文字が含まれているケース' do
      let(:cards){ "S0 S２ S14 S04 S5-2" }
      it { expect(msg).to eq ["1番目のカード指定文字が不正です。（S0）", "2番目のカード指定文字が不正です。（S２）", "3番目のカード指定文字が不正です。（S14）", "4番目のカード指定文字が不正です。（S04）", "5番目のカード指定文字が不正です。（S5-2）"] }
    end
    context 'カードは5枚だがスートと数字それぞれに不正文字が含まれているケース' do
      let(:cards){ "S1 S２ U4 c09 S5" }
      it { expect(msg).to eq ["2番目のカード指定文字が不正です。（S２）", "3番目のカード指定文字が不正です。（U4）", "4番目のカード指定文字が不正です。（c09）"] }
    end

    context 'カードは5枚で不正文字もないが重複が存在するケース' do
      let(:cards){ "S1 S2 S2 S4 S5" }
      it { expect(msg).to eq ["カードが重複しています。"] }
    end

  end
end
