ActiveAdmin.register Software do
#  menu parent: "In Development"
  menu :label => "Software"
  permit_params :software_name, :software_version

  actions :index, :show, :new, :create, :update, :destroy #, :edit 
  
# Index
  index do
    selectable_column
    column :software_name do |ii| best_in_place ii, :software_name, :type => :input, :path => [:admin, ii] end
    column :software_version do |ii| best_in_place ii, :software_version, :type => :input, :path => [:admin, ii] end
    column "Inventory Items with Software" do |software|
      link_to "View Inventory Items with Software (#{software.inventoryitem_softwares.count})", :controller => "inventoryitem_softwares", :action => "index", 'q[software_id_eq]' => "#{software.id}".html_safe
    end
    
    actions
  end

  # batch actions
  batch_action :duplicate do |ids|
    Software.find(ids).each do |sw|
      new_software = sw.dup
      new_software.save
    end
    redirect_to collection_path, alert: "#{ids.size} Softwares have been duplicated"
  end
  
# show
  show do
    attributes_table do
      row :software_name do |s|  best_in_place s, :software_name, :type => :input,:path =>[:admin,s] end
      row :software_version do |s|  best_in_place s, :software_version, :type => :input,:path =>[:admin,s] end
    end
    panel "Inventory Items" do
      table_for software.inventoryitem_softwares do
        column "Inventory Item" do |is| is.inventoryitem.faa_bar_code end
        column "Installed Software" do |is| is.software.software_name end
        column "Version" do            |is| is.software.software_version end
        column :instalation_date
        column :license_number do |ii| best_in_place ii, :license_number, :type => :input,:path =>[:admin,ii] end
        column :license_type do |ii| best_in_place ii, :license_type, :type => :input,:path =>[:admin,ii] end
        column :license_creation_date
        column :license_expiration_date
      end          
    end
  end

#  show do
#    panel "Inventory Items" do
#      table_for software.inventoryitem_softwares do
#        column "Software" do |is|
#          is.software.software_name
#        end
#        column "Systems with this Software" do |is|
#          is.inventoryitem.faa_bar_code
#        end
#        column :instalation_date
#        column :license_number
#        column :license_name
#        column :license_type
#        column :license_creation_date
#        column :license_expiration_date
#      end
#    end
#  end

end
