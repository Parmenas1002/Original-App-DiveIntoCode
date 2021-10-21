class Category < ApplicationRecord
    validates :name, presence:true
    has_many :movies, dependent: :destroy
end
