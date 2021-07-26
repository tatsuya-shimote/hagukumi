class Micropost < ApplicationRecord
  has_many :likes, dependent: :destroy
  belongs_to :user
  has_many :be_liked_user, through: :likes, source: :user
  validates :content, presence: true, length: {maximum: 140}
end
