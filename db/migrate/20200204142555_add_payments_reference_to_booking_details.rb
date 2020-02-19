class AddPaymentsReferenceToBookingDetails < ActiveRecord::Migration[5.2]
  def change
    add_reference :payments, :booking_detail, foreign_key: true
  end
end
