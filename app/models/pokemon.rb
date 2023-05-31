class Pokemon < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  validates :name, presence: true
  validates :nature, presence: true
  validates :category, presence: true
  validates :price, presence: true

  CATEGORIES = [
    "Transport aerien",
    "Transport terrestre",
    "Transport aquatique",
    "Pompier",
    "Police",
    "Soin"
  ]

  NATURE = [
    "Insecte",
    "Plante",
    "Fée",
    "Sol",
    "Eau",
    "Électrik",
    "Normal",
    "Feu",
    "Poison"
  ]

end
