class UserRole < ApplicationRecord
  has_many :users
  has_many :messages, through: :user
end
