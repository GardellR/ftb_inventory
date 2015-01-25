class CreateInventoryitems < ActiveRecord::Migration
  def change
    create_table :inventoryitems do |t|
      t.string :organization
      t.string :faa_bar_code
      t.string :item_type
      t.text :item_description
      t.decimal :cost
      t.string :barcode_is_in_aits
      t.date :warranty_expiration_date
      t.references :ftbsystemtype, index: true

      t.timestamps
    end
  end
end
