class Post < ApplicationRecord
  belongs_to :postable, polymorphic: true
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  validates :title, presence: true, length: { maximum: 100 }
  validates :body, presence: true, length: { maximum: 200 }
  validates :address, presence: true

  geocoded_by :address
  after_validation :geocode
end
