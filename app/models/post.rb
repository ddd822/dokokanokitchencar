class Post < ApplicationRecord
  belongs_to :postable, polymorphic: true
  validates :title, presence: true, length: { maximum: 100 }
  validates :body, presence: true, length: { maximum: 200 }
end
