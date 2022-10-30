RSpec.describe Profile, type: :model do
  describe 'モデルのテスト' do
    it "有効なProfileの場合は保存されるか" do
      expect(build(:profile)).to be_valid
    end

    context "空白のバリデーションチェック" do
      it "titleが空白の場合にエラーメッセージが返ってくるか" do
        profile = build(:profile, profile: nil)
        profile.valid?
        expect(profile.errors[:profile]).to include("を入力してください")
      end

      it "profileが空白の場合にエラーメッセージが返ってくるか" do
        profile = build(:profile, profile: nil)
        profile.valid?
        expect(profile.errors[:profile]).to include("を入力してください")
      end

      it "profileの文字数が50文字以上の場合エラーメッセージが返ってくるか" do
        profile = create(:profile)
        # Faker::Lorem.characters(number: 141)でランダムな文字列を50字で作成できる
        profile.profile = Faker::Lorem.characters(number: 55)
        profile.valid?
        expect(profile.errors[:profile]).to include("は50文字以内で入力してください")
      end

      it "profileの文字数が50文字以上の場合エラーメッセージが返ってくるか" do
        profile = create(:profile)
        # Faker::Lorem.characters(number: 141)でランダムな文字列を141字で作成できる
        profile.profile = Faker::Lorem.characters(number: 55)
        profile.valid?
        expect(profile.errors[:profile]).to include("は55文字以内で入力してください")
      end
    end
  end
end
