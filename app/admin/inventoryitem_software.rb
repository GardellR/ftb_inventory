ActiveAdmin.register InventoryitemSoftware do

  permit_params :software, :inventoryitem, :instalation_date, :license_number, :license_name, :license_type, :license_creation_date, :license_expiration_date
  menu :label => "Software Installations", priority: 3
  filter :software

  scope :all, :default => true do |iis|   # needed to get sorting on ftbsystemtype working
    iis.includes [:inventoryitem, :software]
  end
  scope "Expired", :expired
  scope "Expiring in 30 days", :will_expire_30
  scope "Expiring in 60 days", :will_expire_60

  index :title => "Software Installations" do
    selectable_column
    column "License Number", :license_number  do |ii| best_in_place ii, :license_number, :type => :input,:path =>[:admin,ii] end
    column "Softwares", :software, :sortable => 'softwares.software_name'  # requires scope :all
    column "Inventory Items", :inventoryitem, :sortable => 'inventoryitems.faa_bar_code'  # requires scope :all
    column "FTB System Type", :inventoryitem, :sortable => 'inventoryitems.faa_bar_code' do |x|
      x.inventoryitem.ftbsystemtype.name
    end
    column "Installation Date", :instalation_date do |ii| best_in_place ii, :license_creation_date, :type => :input,:path =>[:admin,ii] end
    column "License Type", :license_type  do |ii| best_in_place ii, :license_type, :type => :input,:path =>[:admin,ii] end
    column "License Expiration Date", :license_expiration_date do |ii| best_in_place ii, :license_expiration_date, :type => :input,:path =>[:admin,ii] end
    actions
  end

  show do
    attributes_table do
      row :inventoryitem
      row :software
      row :instalation_date do |ii| best_in_place ii, :instalation_date, :type => :input,:path =>[:admin,ii] end
      row :license_number do |ii| best_in_place ii, :license_number, :type => :input,:path =>[:admin,ii] end
      row :license_name do |ii| best_in_place ii, :license_name, :type => :input,:path =>[:admin,ii] end
      row :license_type do |ii| best_in_place ii, :license_type, :type => :input,:path =>[:admin,ii] end
      row :license_creation_date do |ii| best_in_place ii, :license_creation_date, :type => :input,:path =>[:admin,ii] end
      row :license_expiration_date do |ii| best_in_place ii, :license_expiration_date, :type => :input,:path =>[:admin,ii] end
    end
  end

end
