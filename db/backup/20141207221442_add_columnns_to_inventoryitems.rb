class AddColumnnsToInventoryitems < ActiveRecord::Migration
  def change
    add_column :inventoryitems, :part_number, :string
    add_column :inventoryitems, :computer_name, :string
    add_column :inventoryitems, :location, :string
    add_column :inventoryitems, :manufacturer, :string
    add_column :inventoryitems, :model_number, :string
    add_column :inventoryitems, :serial_number, :string
    add_column :inventoryitems, :owner, :string
    add_column :inventoryitems, :task, :string
    add_column :inventoryitems, :location_function, :string
    add_column :inventoryitems, :purchase_method, :string
    add_column :inventoryitems, :order_number, :string
    add_column :inventoryitems, :vendor, :string
    add_column :inventoryitems, :intended_term_of_use, :string
    add_column :inventoryitems, :decomm_date, :date
    add_column :inventoryitems, :purchase_date, :date
    add_column :inventoryitems, :inventory_date, :date
    add_column :inventoryitems, :next_maintanence_date, :date
    add_column :inventoryitems, :next_maintanence, :string
    add_column :inventoryitems, :notes, :text
    add_column :inventoryitems, :hostname, :string
    add_column :inventoryitems, :os_name, :string
    add_column :inventoryitems, :os_version, :string
    add_column :inventoryitems, :ip_address, :string
  end
end
