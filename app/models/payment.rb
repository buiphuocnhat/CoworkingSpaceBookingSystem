class Payment < ApplicationRecord
  has_one :booking_detail
end
