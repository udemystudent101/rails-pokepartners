class Booking < ApplicationRecord
  belongs_to :pokemon
  belongs_to :user

  validates :user_id, presence: true, uniqueness: { scope: :pokemon_id }
  validates :pokemon_id, presence: true
  validates :end_date, presence: true, comparison: { greater_than: :start_date }

  def duration
    s = start_date
    e = end_date
    duration_time = e - s
    return duration.nil? ? "error" : duration_time
  end

end

# book = Booking.new(user_id: 1, pokemon_id: 1, start_date: a, end_date: b)
