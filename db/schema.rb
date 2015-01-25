# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141207221442) do

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "ftbsystemtypes", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "purpose"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "inventoryitem_softwares", force: true do |t|
    t.integer  "software_id"
    t.integer  "inventoryitem_id"
    t.date     "instalation_date"
    t.string   "license_number"
    t.string   "license_name"
    t.string   "license_type"
    t.date     "license_creation_date"
    t.date     "license_expiration_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "inventoryitem_softwares", ["inventoryitem_id"], name: "index_inventoryitem_softwares_on_inventoryitem_id", using: :btree
  add_index "inventoryitem_softwares", ["software_id"], name: "index_inventoryitem_softwares_on_software_id", using: :btree

  create_table "inventoryitems", force: true do |t|
    t.string   "organization"
    t.string   "faa_bar_code"
    t.string   "item_type"
    t.text     "item_description"
    t.decimal  "cost",                     precision: 10, scale: 0
    t.string   "barcode_is_in_aits"
    t.date     "warranty_expiration_date"
    t.integer  "ftbsystemtype_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "part_number"
    t.string   "computer_name"
    t.string   "location"
    t.string   "manufacturer"
    t.string   "model_number"
    t.string   "serial_number"
    t.string   "owner"
    t.string   "task"
    t.string   "location_function"
    t.string   "purchase_method"
    t.string   "order_number"
    t.string   "vendor"
    t.string   "intended_term_of_use"
    t.date     "decomm_date"
    t.date     "purchase_date"
    t.date     "inventory_date"
    t.date     "next_maintanence_date"
    t.string   "next_maintanence"
    t.text     "notes"
    t.string   "hostname"
    t.string   "os_name"
    t.string   "os_version"
    t.string   "ip_address"
  end

  add_index "inventoryitems", ["ftbsystemtype_id"], name: "index_inventoryitems_on_ftbsystemtype_id", using: :btree

  create_table "softwares", force: true do |t|
    t.string   "software_name"
    t.string   "software_version"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "virtualinstances", force: true do |t|
    t.integer  "inventoryitem_id"
    t.integer  "ftbsystemtype_id"
    t.string   "virt_hostname"
    t.string   "virt_os_name"
    t.string   "virt_os_version"
    t.string   "virt_ip_address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "virtualinstances", ["ftbsystemtype_id"], name: "index_virtualinstances_on_ftbsystemtype_id", using: :btree
  add_index "virtualinstances", ["inventoryitem_id"], name: "index_virtualinstances_on_inventoryitem_id", using: :btree

end
