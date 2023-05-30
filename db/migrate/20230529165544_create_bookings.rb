class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.references :pokemon, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :start_date
      t.string :end_date
      t.integer :price

      t.timestamps
    end
  end
end
