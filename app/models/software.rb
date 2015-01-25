class Software < ActiveRecord::Base
  has_many :inventoryitem_softwares, dependent: :destroy
  has_many :inventoryitems, :through => :inventoryitem_softwares

  def display_name
    software_name
  end

end
