class Virtualinstance < ActiveRecord::Base
  belongs_to :inventoryitem
  belongs_to :ftbsystemtype
end
