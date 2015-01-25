ActiveAdmin.register Virtualinstance do
  menu false
  permit_params :virtualinstance, :inventoryitem, :ftbsystemtype, :virt_hostname, :virt_os_name, :virt_os_version, :virt_ip_address
#  permit_params :organization, :faa_bar_code, :item_type, :item_description, :cost, :barcode_is_in_aits, :warranty_expiration_date, :ftbsystemtype_id

  index do
    selectable_column
    column :virt_hostname do |vi| best_in_place vi, :virt_hostname, :type => :input,:path =>[:admin,vi] end
    column :virt_os_name do |vi| best_in_place vi, :virt_os_name, :type => :input,:path =>[:admin,vi] end
    column :virt_os_version do |vi| best_in_place vi, :virt_os_version, :type => :input,:path =>[:admin,vi] end
    column :virt_ip_address do |vi| best_in_place vi, :virt_ip_address, :type => :input,:path =>[:admin,vi] end
  end
end
