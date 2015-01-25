class CreateInventoryitemSoftwares < ActiveRecord::Migration
  def change
    create_table :inventoryitem_softwares do |t|
      t.references :software, index: true
      t.references :inventoryitem, index: true
      t.date :instalation_date
      t.string :license_number
      t.string :license_name
      t.string :license_type
      t.date :license_creation_date
      t.date :license_expiration_date

      t.timestamps
    end
  end
end
