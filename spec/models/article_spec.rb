require 'rails_helper'

RSpec.describe Article, type: :model do
  article = FactoryBot.create(:article)

  it 'articleインスタンスが有効' do
    expect(article).to be_valid
  end
end
