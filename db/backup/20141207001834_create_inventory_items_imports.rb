class CreateInventoryItemsImports < ActiveRecord::Migration
  def change
    create_table "inventory_items_import", id: false, force: true do |t|
      t.string "organization",         null: false
      t.string "faa_bar_code",         null: false
      t.string "computer_name",        null: false
      t.string "location_1",           null: false
      t.string "ip_Address",           null: false
      t.string "item_type",            null: false
      t.string "manufacturer",         null: false
      t.string "part_no",              null: false
      t.text   "item_description",     null: false
      t.text   "serial_no",            null: false
      t.string "ftb_use",              null: false
      t.string "ftb_system",           null: false
      t.string "ftb_owner",            null: false
      t.string "task",                 null: false
      t.string "location_2",           null: false
      t.string "purchase_method",      null: false
      t.string "order_number",         null: false
      t.string "vendor",               null: false
      t.string "cost",                 null: false
      t.string "intended_term_of_Use", null: false
      t.string "decomm_date",          null: false
      t.string "purchase_date",        null: false
      t.string "inventory_date",       null: false
      t.string "notes",                null: false
      t.string "additional_notes",     null: false
      t.string "barcode_in_aits",      null: false
      t.string "ftb_comments",         null: false
      t.string "je_comments",          null: false
      t.string "may_6_2014_comments",  null: false
      t.string "may_20",               null: false
    end
  end
end


