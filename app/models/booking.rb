class Booking < ApplicationRecord
  belongs_to :pokemon
  belongs_to :user

  validates :user_id, presence: true, uniqueness: { scope: :pokemon_id }
  validates :pokemon_id, presence: true
  validates :start_date, presence: true, comparison: { greater_than: :end_date }

  def duration
    duration = end_date.to_time - start_date.to_time
    duration.nil? ? "error" : duration
  end
end

# book = Booking.new(user_id: 1, pokemon_id: 1, start_date: a, end_date: b)
