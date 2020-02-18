class Space < ApplicationRecord
  belongs_to :venue
  belongs_to :user, class_name: "User", foreign_key: "manager_id"
  belongs_to :type
  belongs_to :space_price
  has_many :booking_details
  scope :search_name, ->(name){joins(venue: :address).where("addresses.name like ? ", "%#{name}%")}
  scope :search_city, ->(city){joins(venue: :address).where("addresses.city like ? ", "%#{city}%")}
  scope :type, ->(type){where("spaces.type IN ?", type)}
end
