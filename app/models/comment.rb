class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user, polymorphic: true
  validates :body, presence: true, length: { maximum: 200 }
end
