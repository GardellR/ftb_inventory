class Ftbsystemtype < ActiveRecord::Base
  
#  has_many :inventoryitems
  has_many :inventoryitems, dependent: :nullify
#  has_many :inventoryitems, dependent: :destroy

  def display_name
    name
  end
  
end
