class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
        #  :confirmable
  # アソシエーション
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  # has_secure_password
  # validates :name, presence: true
  # validates :gender, presence: true
  # validates :email, presence: true
  # validates :phone_number, presence: true
  # validates :remarks, presence: true, length: { maximum: 300 }
end
