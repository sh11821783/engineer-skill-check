class Article < ApplicationRecord
  belongs_to :employee
  validates :title, presence: true, length: { in: 1..50 }
  validates :content, presence: true, length: { in: 1..50 }
end
