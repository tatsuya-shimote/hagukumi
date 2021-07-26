class User < ApplicationRecord
  mount_uploader :image, ProfileimageUploader
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
            format:{with:VALID_EMAIL_REGEX},
            uniqueness: true
  has_many :hugs, dependent: :destroy
  has_secure_password
  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :followings, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :follower, through: :passive_relationships, source: :follower
  has_many :microposts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :likes_post, through: :likes, source: :micropost
  
  
  def follow(other_user)
    unless self == other_user
      self.active_relationships.find_or_create_by(followed_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.active_relationships.find_by(followed_id: other_user.id)
    relationship.destroy if relationship
  end
  
  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  def like(micropost)
    unless self.likes.find_by(micropost_id: micropost.id)
      self.likes.create(micropost_id: micropost.id)
    end
  end
  
  def unlike(micropost)
    like = self.likes.find_by(micropost_id: micropost.id)
    like.destroy if like
  end
  
  def like?(micropost)
    self.likes_post.include?(micropost)
  end
end
