class User < ApplicationRecord
  # アソシエーション
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :name, presence: true
  validates :gender, presence: true
  validates :email, presence: true
  validates :phone_number, presence: true
  validates :remarks, presence: true, length: { maximum: 300 }
end
