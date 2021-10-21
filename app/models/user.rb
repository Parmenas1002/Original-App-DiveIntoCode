class User < ApplicationRecord
  validates :name, presence:true, length: {minimum:3, maximum:30}
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :favorites, dependent: :destroy
  has_many :favorite_movies, through: :favorites, source: :movie
  has_many :comments, dependent: :destroy
end
