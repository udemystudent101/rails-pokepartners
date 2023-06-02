class Pokemon < ApplicationRecord
  belongs_to :user
  has_many :users, through: :bookings
  has_many :bookings, dependent: :destroy

  has_one_attached :photo
  validates :name, presence: true
  validates :nature, presence: true
  validates :category, presence: true
  validates :price, presence: true
  validates :details, presence: true

  CATEGORIES = [
    "Transport aerien",
    "Transport terrestre",
    "Transport aquatique",
    "Pompier",
    "Police",
    "Soin",
    "Exploration",
    "Garde du corps",
    "Nettoyage"
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
