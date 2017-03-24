class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.string :customer_name
      t.text :comment
      t.date :booked_from
      t.date :booked_to
      t.integer :price

      t.timestamps null: false
    end
  end
end
