class Space < ApplicationRecord
  belongs_to :venue
  belongs_to :type
  belongs_to :user
  has_one :price
  has_many :booking_details
  # mount_uploader :picture, PictureUploader
  scope :search_name, lambda{|name|
  return if name.blank?

  where("addresses.name like ? ", "%#{name}%")                      }
  scope :search_city, lambda{|city|
  return if city.blank?

  where("addresses.city like ? ", "%#{city}%")                      }
end
