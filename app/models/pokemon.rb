class Pokemon < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  validates :nature, presence: true
  validates :category, presence: true
  validates :price, presence: true
end
