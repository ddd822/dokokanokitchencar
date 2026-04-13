class Post < ApplicationRecord
  attr_accessor :post_tag_params

  belongs_to :postable, polymorphic: true
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  validates :title, presence: true, length: { maximum: 100 }
  validates :body, presence: true, length: { maximum: 200 }
  validates :address, presence: true

  geocoded_by :address
  after_validation :geocode

  after_update :reload_tags

  private 

  def reload_tags
    find_or_create_tags
    all_tags = Tag.all
    delete_tags = all_tags.where.not(id: all_tags.joins(:post_tags).group(:id).ids)
    delete_tags.destroy_all
  end

  def find_or_create_tags
    if post_tag_params.present?
      self.tags = post_tag_params.split(',').map(&:strip).uniq.map do |name|
        Tag.find_or_create_by(name: name)
      end
    end
  end
end
