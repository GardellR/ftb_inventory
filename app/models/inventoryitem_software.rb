class InventoryitemSoftware < ActiveRecord::Base
  belongs_to :software
  belongs_to :inventoryitem

  def display_name
    "Software Installation: License Number #{license_number}"
  end

#  scope :expiring, -> { where(license_number: '889') }
#  scope :published_last_week, where('license_expiration_date >= ?', 1.week.ago)
#  scope :expired, lambda { where(   "license_expiration_date < ?", Date.today) }
  scope :will_expire_60, lambda { where(   "license_expiration_date < ?", Date.today+60.days) }
  scope :will_expire_30, lambda { where(   "license_expiration_date < ?", Date.today+30.days) }
  scope :expired, lambda { where(   "license_expiration_date < ?", Date.today) }
end
