class Space < ApplicationRecord
  belongs_to :venue
  belongs_to :user, class_name: "User", foreign_key: "manager_id"
  belongs_to :type
  belongs_to :space_price
  has_many :booking_details
end
