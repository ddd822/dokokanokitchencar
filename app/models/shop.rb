class Shop < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
has_many :posts, as: :postable, dependent: :destroy
has_many :comments, as: :user, dependent: :destroy
validates :name, presence: true, uniqueness: true, length: { maximum: 30 }
validates :telephone_number, length: { maximum: 11 }
validates :introduction, length: { maximum: 300 }
end
