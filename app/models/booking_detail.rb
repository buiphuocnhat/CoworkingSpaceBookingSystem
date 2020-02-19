class BookingDetail < ApplicationRecord
  belongs_to :space
  has_many :payments
  validates :time_use_start, :time_use_close, presence: true

  # validate :check_booking

  # def check_booking
  #   is_exists = true
  #   errors.add :time_use_start, :duplicated if is_exists
  # end
end
