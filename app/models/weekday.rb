class Weekday < ApplicationRecord
  has_many :regular_holidays, dependent: :destroy
  has_many :shops, through: :regular_holidays
  
  validates :name, presence: true, uniqueness: true
end
