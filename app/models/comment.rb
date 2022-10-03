class Comment < ApplicationRecord
  belongs_to :post  # postsテーブルとのアソシエーション
  belongs_to :user  # usersテーブルとのアソシエーション
  validates :post_id, presence: true
  validates :user_id, presence: true
  validates :title, presence: true
  validates :body, presence: true
end
