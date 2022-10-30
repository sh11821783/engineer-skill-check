require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'モデルのテスト' do
    it "有効なarticleの場合は保存されるか" do
      expect(build(:article)).to be_valid
    end

    context "空白のバリデーションチェック" do
      it "titleが空白の場合にエラーメッセージが返ってくるか" do
        article = build(:article, title: nil)
        article.valid?
        expect(article.errors[:title]).to include("を入力してください")
      end

      it "contentが空白の場合にエラーメッセージが返ってくるか" do
        article = build(:article, content: nil)
        article.valid?
        expect(article.errors[:content]).to include("を入力してください")
      end

      it "titleの文字数が50文字以上の場合エラーメッセージが返ってくるか" do
        article = create(:article)
        # Faker::Lorem.characters(number: 141)でランダムな文字列を50字で作成できる
        article.title = Faker::Lorem.characters(number: 55)
        article.valid?
        expect(article.errors[:title]).to include("は50文字以内で入力してください")
      end

      it "contentの文字数が50文字以上の場合エラーメッセージが返ってくるか" do
        article = create(:article)
        # Faker::Lorem.characters(number: 141)でランダムな文字列を141字で作成できる
        article.content = Faker::Lorem.characters(number: 55)
        article.valid?
        expect(article.errors[:content]).to include("は55文字以内で入力してください")
      end
    end
  end
end
