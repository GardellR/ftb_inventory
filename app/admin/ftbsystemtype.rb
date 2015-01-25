ActiveAdmin.register Ftbsystemtype do
  permit_params :name, :description, :purpose
  config.sort_order = 'name_asc'

  #  menu false
  menu :label => "FTB Systems",  priority: 1

  filter :name
  filter :description

  actions :index, :new, :create, :update, :destroy, :show  #, :edit, :show
  
  index :title => "FTB Systems" do
    selectable_column
    column "Name", :name do |ii| best_in_place ii, :name, :type => :textarea,:path =>[:admin,ii] end
#    column :description do |ii| best_in_place ii, :description, :type => :input,:path =>[:admin,ii] end
    column :description do |ii| best_in_place ii, :description, :type => :textarea,:path =>[:admin,ii] end
    column "Inventory Items", "Inventoryitems" do |ftbsystemtype|
      link_to "View associated Inventoryitems (#{ftbsystemtype.inventoryitems.count})", :controller => "inventoryitems", :action => "index", 'q[ftbsystemtype_id_eq]' => "#{ftbsystemtype.id}".html_safe
    end
    actions
  end

  # Batch
  batch_action :duplicate do |ids|
    Ftbsystemtype.find(ids).each do |fst|
      new_fst = fst.dup
      new_fst.save
    end
    redirect_to collection_path, alert: "#{ids.size} FTB Systems have been duplicated"
  end
  batch_action :import do |ids|
    Inventoryitem.import_all
    redirect_to collection_path, alert: "#{ids.size} Inventoryitems have been imported"
  end

  # Show
  show do
    attributes_table do
      row :name do |ii| best_in_place ii, :name, :type => :input,:path =>[:admin,ii] end
      row :description  do |ii| best_in_place ii, :description, :type => :input,:path =>[:admin,ii] end
    end
    panel "Inventory Items" do
      table_for ftbsystemtype.inventoryitems do
        column :organization
        column :faa_bar_code do |inventoryitem|
          link_to inventoryitem.faa_bar_code, admin_inventoryitem_path(inventoryitem)
        end
        column :item_type do |ii| best_in_place ii, :item_type, :type => :input,:path =>[:admin,ii] end
      end
    end
  end

end
