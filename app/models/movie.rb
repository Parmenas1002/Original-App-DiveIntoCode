class Movie < ApplicationRecord
  validates :name, presence:true, length: {minimum:3, maximum:30}
  validates :description, presence:true
  mount_uploader :image, ImageUploader
  mount_uploader :video, VideoUploader
  belongs_to :user
  belongs_to :category
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  has_many :comments, dependent: :destroy
  paginates_per 10

  scope :search_with_key, ->(key){where("name LIKE ? OR description LIKE ?", "%#{key}%", "%#{key}%")}
end
