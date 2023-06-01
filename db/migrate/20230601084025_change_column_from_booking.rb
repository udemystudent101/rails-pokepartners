class ChangeColumnFromBooking < ActiveRecord::Migration[7.0]
  def change
    remove_column :bookings, :start_date, :string
    remove_column :bookings, :end_date, :string
    add_column :bookings, :start_date, :date
    add_column :bookings, :end_date, :date
  end
end
