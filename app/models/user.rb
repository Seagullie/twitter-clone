class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, uniqueness: true
  validates :email, uniqueness: true

  has_many :tweeets, dependent: :destroy
  has_many :follows, dependent: :destroy

  has_one_attached :avatar, dependent: :destroy
  
end
