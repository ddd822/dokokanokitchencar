class Post < ApplicationRecord
  belongs_to :postable, polymorphic: true
  has_many :comments, as: :commentable, dependent: :destroy
  validates :title, presence: true, length: { maximum: 100 }
  validates :body, presence: true, length: { maximum: 200 }
  
end
