class CreateVirtualinstances < ActiveRecord::Migration
  def change
    create_table :virtualinstances do |t|
      t.references :inventoryitem, index: true
      t.references :ftbsystemtype, index: true
      t.string :virt_hostname
      t.string :virt_os_name
      t.string :virt_os_version
      t.string :virt_ip_address

      t.timestamps
    end
  end
end
