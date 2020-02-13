class Venue < ApplicationRecord
  has_many :spaces
  has_one :address
  belongs_to :user, class_name: "User", foreign_key: "belongs_to_user_id"
end
