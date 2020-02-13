class BookingDetail < ApplicationRecord
  belongs_to :user
  belongs_to :space
  belongs_to :payment
end
