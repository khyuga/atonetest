require 'rails_helper'

include PokerAPI

RSpec.describe PokerAPI do
  let(:error) { PokerAPI.api_output(cards_array)[:error] }
  let(:result) { PokerAPI.api_output(cards_array)[:result] }

  describe '正常系' do
    context '正常なカードの組み合わせが1つ送信されるケース' do
      let(:cards_array) do
        [
          'C13 S12 C11 C10 C7'
        ]
      end
      it 'カードと役名とベスト判定' do
        expect(result).to eq [{ cards: 'C13 S12 C11 C10 C7', hand: 'ハイカード', best: true }]
      end
    end

    context '正常なカードの組み合わせが2つ以上送信されるケース' do
      let(:cards_array) do
        [
          'C13 S12 C11 C10 C7',
          'H9 C9 S9 H2 C2',
          'H9 S9 D11 H11 H10'
        ]
      end
      it 'カードと役名とベスト判定' do
        expect(result).to eq [
          { cards: 'C13 S12 C11 C10 C7', hand: 'ハイカード', best: false },
          { cards: 'H9 C9 S9 H2 C2', hand: 'フルハウス', best: true },
          { cards: 'H9 S9 D11 H11 H10', hand: 'ツーペア', best: false }
        ]
      end
    end
  end

  describe '純正常系' do
    context '不正カードを1つ含む組み合わせが送信されるケース' do
      let(:cards_array) do
        [
          'H9 C9 S9 H2 C22'
        ]
      end
      it 'カードとエラー内容' do
        expect(error).to eq [{ cards: 'H9 C9 S9 H2 C22', msg: '5番目のカード指定文字が不正です。（C22）' }]
      end
    end
    context '不正カードを複数含む組み合わせが送信されるケース' do
      let(:cards_array) do
        [
          'H9 C9 S9 H22 C22'
        ]
      end
      it 'カードとエラー内容' do
        expect(error).to eq [{ cards: 'H9 C9 S9 H22 C22',
                               msg: ['4番目のカード指定文字が不正です。（H22）', '5番目のカード指定文字が不正です。（C22）'] }]
      end
    end

    context '不正カード、重複、枚数違反を含む組み合わせ、及び未入力が送信されるケース' do
      let(:cards_array) do
        [
          'H9 C9 S9 H22 C2',
          'H1 H13 W12 H11 H11',
          'C13 D12 C11 H8',
          ''
        ]
      end
      it 'カードとエラー内容' do
        expect(error).to eq [
          { cards: 'H9 C9 S9 H22 C2', msg: '4番目のカード指定文字が不正です。（H22）' },
          { cards: 'H1 H13 W12 H11 H11',
            msg: ['3番目のカード指定文字が不正です。（W12）', 'カードが重複しています。（H11）'] },
          { cards: 'C13 D12 C11 H8',
            msg: '5つのカード指定文字を半角スペース区切りで入力してください。（例："S1 H3 D9 C13 S11"）' },
          { cards: '', msg: 'カードを入力してください。' }
        ]
      end
    end

    context '正常な組み合わせとエラーを含む組み合わせが同時に送信されるケース' do
      let(:cards_array) do
        [
          'H1 H13 H12 H11 H11',
          'H9 S9 D11 H11 H10',
          'C13 D12 C11 H8 H7 H10',
          'H9 C9 S9 H2 C2'
        ]
      end
      it '正常な組み合わせのカードと役名とベスト判定' do
        expect(result).to eq [
          { cards: 'H9 S9 D11 H11 H10', hand: 'ツーペア', best: false },
          { cards: 'H9 C9 S9 H2 C2', hand: 'フルハウス', best: true }
        ]
      end
      it 'エラーを含む組み合わせのカードとエラー内容' do
        expect(error).to eq [
          { cards: 'H1 H13 H12 H11 H11', msg: 'カードが重複しています。（H11）' },
          { cards: 'C13 D12 C11 H8 H7 H10',
            msg: '5つのカード指定文字を半角スペース区切りで入力してください。（例："S1 H3 D9 C13 S11"）' }
        ]
      end
    end
  end
end
