class RegularHoliday < ApplicationRecord
  belongs_to :shop
  belongs_to :weekday

  validates :shop_id, uniqueness: { scope: :weekday_id }
end
