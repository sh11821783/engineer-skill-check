require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe 'モデルのテスト' do

    it "有効なemployeeの場合は保存されるか" do
      # FactoryBotで作ったデータが有効であるか確認しています
      expect(build(:employee)).to be_valid
    end

    context "空白のバリデーションチェック" do
      it "first_nameが空白の場合にエラーメッセージが返ってくるか" do
        # employeeにfirst_nameカラムを空で保存したものを代入
        employee = build(:employee, first_name: nil)
        # employeeにfirst_nameカラムを空で保存したものを代入
        employee = build(:employee, first_name: nil)
        # バリデーションチェックを行う
        employee.valid?
        # nameカラムでエラーが出て、エラーメッセージに"を入力してください"が含まれているか？
        expect(employee.errors[:first_name]).to include("を入力してください")
      end

      it "last_nameが空白の場合にエラーメッセージが返ってくるか" do
        # employeeにlast_nameカラムを空で保存したものを代入
        employee = build(:employee, last_name: nil)
        # employeeにlast_nameカラムを空で保存したものを代入
        employee = build(:employee, last_name: nil)
        # バリデーションチェックを行う
        employee.valid?
        # last_nameカラムでエラーが出て、エラーメッセージに"を入力してください"が含まれているか？
        expect(employee.errors[:last_name]).to include("を入力してください")
      end

      it "emailが空白の場合にエラーメッセージが返ってくるか" do
        # emailのバリデーションチェック
        employee = build(:employee, email: nil)
        employee.valid?
        expect(employee.errors[:email]).to include("を入力してください")
      end

      it "passwordが空白の場合にエラーメッセージが返ってくるか" do
        # passwordのバリデーションチェック
        employee = build(:employee, password: nil)
        employee.valid?
        expect(employee.errors[:password]).to include("を入力してください")
      end

      context "一意性制約の確認" do
        # itの前に@employeeにbuild(:employee)を代入
        before do
          @employee = build(:employee)
        end
  
        it "同じnumberの場合エラーメッセージが返ってくるか" do
          # @employeeを保存
          @employee.save
          # another_employeeにbuild(:employee)を保存
          another_employee = build(:employee)
          # another_employeeのnumberカラムに@employeeと同じnumberを代入
          another_employee.number = @employee.number
          # @employeeと同じnumberになるので、バリデーションチェックに引っかかる
          another_employee.valid?
          expect(another_employee.errors[:number]).to include("はすでに存在します")
        end
      end
    end
  end
end