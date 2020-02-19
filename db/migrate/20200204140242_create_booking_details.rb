class CreateBookingDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :booking_details do |t|
      t.datetime :time_use_start
      t.datetime :time_use_close
      t.boolean :status, :default => false

      t.timestamps
    end
  end
end
