class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :user_id, presence: true
  validates :titile, presence: true
  validates :body, presence: true
end
