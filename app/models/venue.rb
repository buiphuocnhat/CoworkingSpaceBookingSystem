class Venue < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  enum status: {block: 0, approve: 1}
  has_one :address, dependent: :destroy
  has_many :amenities, dependent: :destroy
  has_many :spaces, dependent: :destroy
  accepts_nested_attributes_for :amenities, :address, reject_if: proc{|attributes| attributes["name"].blank?}
end
