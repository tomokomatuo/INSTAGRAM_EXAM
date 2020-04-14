class Blog < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :image, presence: true
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  belongs_to :user
end
