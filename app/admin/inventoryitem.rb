ActiveAdmin.register Inventoryitem do

  permit_params :organization, :faa_bar_code, :item_type, :item_description, :computer_name, :location, :manufacturer, :model_number, :serial_number, :owner, :task, :location_function, :purchase_method, :order_number, :vendor, :cost, :intended_term_of_use, :decomm_date, :purchase_date, :inventory_date, :barcode_is_in_aits, :warranty_expiration_date, :next_maintanence_date, :next_maintanence, :notes, :hostname, :os_name, :os_version, :ip_address

  menu :label => "Inventory Items", priority: 2

  actions :index, :new, :create, :update, :destroy, :show, :edit

#  scope :all, default: true
#  scope "ANG-C5", :ang_c5
#  scope "ANG-C4", :ang_c4
  scope :all, :default => true do |inventoryitems|   # needed to get sorting on ftbsystemtype working
    inventoryitems.includes [:ftbsystemtype]
  end
  scope "Servers", :systems
  scope "Warrentee Expiration 60 days", :will_expire_60  
  
  filter :organization, as: :check_boxes, collection: proc { Inventoryitem.all.collect{|ii|ii.organization}.uniq.sort}
  filter :faa_bar_code
#  filter :ftbsystemtype, as: :check_boxes, collection: proc { Inventoryitem.all.collect{|ii|ii.ftbsystemtype}.uniq.sort {|x,y| x.name <=> y.name}}
  filter :item_type, as: :check_boxes, collection: proc { Inventoryitem.all.collect{|ii|ii.item_type}.uniq.sort}

#  filter :item_type, as: :check_boxes, collection: proc { Inventoryitem.all.collect{|ii|ii.item_type}.uniq.sort - ['',nil] }

# This adds a button on the table/index page
#  action_item :can_be_anything do
#    link_to 'new button'
#  end

# Index
  index :title => "Inventory Items" do
    selectable_column
    org_hash = {};Inventoryitem.all.each { |ii| org_hash[ii.organization] = ii.organization}
#    column :faa_bar_code do |ii| best_in_place ii, :faa_bar_code, :type => :input,:path =>[:admin,ii] end
    column :faa_bar_code do |inventoryitem|
      link_to inventoryitem.faa_bar_code, admin_inventoryitem_path(inventoryitem)
    end
    column "FTB Systems", :ftbsystemtype, :sortable => 'ftbsystemtypes.name' do |ii|   # requires scope :all
      ii.ftbsystemtype.name
    end
    column :organization do |ii| best_in_place ii, :organization, :type => :select, :path => [:admin, ii], :collection => org_hash end
    column :item_type do |ii| best_in_place ii, :item_type, :type => :input,:path =>[:admin,ii] end
    column :item_description do |ii| best_in_place ii, :item_description, :type => :textarea,:path =>[:admin,ii] end
    column :computer_name do |ii| best_in_place ii, :computer_name, :type => :textarea,:path =>[:admin,ii] end
    column :location do |ii| best_in_place ii, :location, :type => :textarea,:path =>[:admin,ii] end
    column :manufacturer do |ii| best_in_place ii, :manufacturer, :type => :textarea,:path =>[:admin,ii] end
    column :model_number do |ii| best_in_place ii, :model_number, :type => :textarea,:path =>[:admin,ii] end
    column :serial_number do |ii| best_in_place ii, :serial_number, :type => :textarea,:path =>[:admin,ii] end
    column :owner do |ii| best_in_place ii, :owner, :type => :textarea,:path =>[:admin,ii] end
    column :task do |ii| best_in_place ii, :task, :type => :textarea,:path =>[:admin,ii] end
    column :location_function do |ii| best_in_place ii, :location_function, :type => :textarea,:path =>[:admin,ii] end
    column :hostname do |ii| best_in_place ii, :hostname, :type => :textarea,:path =>[:admin,ii] end
    column :warranty_expiration_date do |ii|
      best_in_place ii, :warranty_expiration_date, :type => :date,:path =>[:admin,ii] #,  :display_with => lambda { |v| v.try(:strftime,'%b %d, %Y') }
    end
    #    column :serial_number do |ii| best_in_place ii, :serial_number, :type => :input,:path =>[:admin,ii] end
#    column "# of Installed Software" do |inventoryitem|
#      "#{inventoryitem.inventoryitem_softwares.count}"
#    end
#    column "Installed Software" do |inventoryitem|
#      link_to "View Installed Software (#{inventoryitem.inventoryitem_softwares.count})", :controller => "inventoryitem_softwares", :action => "index", 'q[inventoryitem_id_eq]' => "#{inventoryitem.id}".html_safe
#    end
    actions
  end

  # batch actions
  batch_action :duplicate do |ids|
    Inventoryitem.find(ids).each do |ii|
      new_inventoryitem = ii.dup
      new_inventoryitem.save
    end
    redirect_to collection_path, alert: "#{ids.size} Inventoryitems have been duplicated"
  end

  batch_action :import do |ids|
    Inventoryitem.import_all
    redirect_to collection_path, alert: "#{ids.size} Inventoryitems have been imported"
  end

# show
  show do
    tabs do
      tab 'Inventory Item' do
        attributes_table do
          row :organization do |ii| best_in_place ii, :organization, :type => :input,:path =>[:admin,ii] end
          row :faa_bar_code do |ii| best_in_place ii, :faa_bar_code, :type => :input,:path =>[:admin,ii] end
          row :ftbsystemtype 
          row :organization do |ii| best_in_place ii, :organization, :type => :input,:path =>[:admin,ii] end
          row :item_type do |ii| best_in_place ii, :item_type, :type => :input,:path =>[:admin,ii] end
          row :item_description do |ii| best_in_place ii, :item_description, :type => :input,:path =>[:admin,ii] end
          row :computer_name do |ii| best_in_place ii, :computer_name, :type => :input,:path =>[:admin,ii] end
          row :location do |ii| best_in_place ii, :location, :type => :input,:path =>[:admin,ii] end
          row :manufacturer do |ii| best_in_place ii, :manufacturer, :type => :input,:path =>[:admin,ii] end
          row :model_number do |ii| best_in_place ii, :model_number, :type => :input,:path =>[:admin,ii] end
          row :serial_number do |ii| best_in_place ii, :serial_number, :type => :input,:path =>[:admin,ii] end
          row :owner do |ii| best_in_place ii, :owner, :type => :input,:path =>[:admin,ii] end
          row :task do |ii| best_in_place ii, :task, :type => :input,:path =>[:admin,ii] end
          row :location_function do |ii| best_in_place ii, :location_function, :type => :input,:path =>[:admin,ii] end
          row :purchase_method do |ii| best_in_place ii, :purchase_method, :type => :input,:path =>[:admin,ii] end
          row :order_number do |ii| best_in_place ii, :order_number, :type => :input,:path =>[:admin,ii] end
          row :vendor do |ii| best_in_place ii, :vendor, :type => :input,:path =>[:admin,ii] end
          row :cost do |ii| best_in_place ii, :cost, :type => :input,:path =>[:admin,ii] end
          row :intended_term_of_use do |ii| best_in_place ii, :intended_term_of_use, :type => :input,:path =>[:admin,ii] end
          row :decomm_date do |ii| best_in_place ii, :decomm_date, :type => :input,:path =>[:admin,ii] end
          row :purchase_date do |ii| best_in_place ii, :purchase_date, :type => :input,:path =>[:admin,ii] end
          row :inventory_date do |ii| best_in_place ii, :inventory_date, :type => :input,:path =>[:admin,ii] end
          row :barcode_is_in_aits, :as => :radio, :collection => [["Yes", 'Yes'], ["No", 'No']]
          row :warranty_expiration_date do |ii| best_in_place ii, :warranty_expiration_date, :type => :input,:path =>[:admin,ii] end
          row :next_maintanence_date do |ii| best_in_place ii, :next_maintanence_date, :type => :input,:path =>[:admin,ii] end
          row :next_maintanence do |ii| best_in_place ii, :next_maintanence, :type => :input,:path =>[:admin,ii] end
          row :notes do |ii| best_in_place ii, :notes, :type => :input,:path =>[:admin,ii] end
          row :hostname do |ii| best_in_place ii, :hostname, :type => :input,:path =>[:admin,ii] end
          row :os_name do |ii| best_in_place ii, :os_name, :type => :input,:path =>[:admin,ii] end
          row :os_version do |ii| best_in_place ii, :os_version, :type => :input,:path =>[:admin,ii] end
          row :ip_address do |ii| best_in_place ii, :ip_address, :type => :input,:path =>[:admin,ii] end
        end
      end
      tab 'Installed Software' do
        panel "Installed Software" do
          table_for inventoryitem.inventoryitem_softwares do
            column "Installed Software"     do |is| is.software.software_name end  # don't want these editable here
            column "Version"                do |is| is.software.software_version end  # don't want these editable here
            column :instalation_date        do |ii| best_in_place ii, :instalation_date, :type => :input,:path =>[:admin,ii] end
            column :license_number          do |inventoryitem_software| link_to inventoryitem_software.license_number, admin_inventoryitem_software_path(inventoryitem_software) end
            column :license_type            do |ii| best_in_place ii, :license_type, :type => :input,:path =>[:admin,ii] end
            column :license_creation_date   do |ii| best_in_place ii, :license_creation_date, :type => :input,:path =>[:admin,ii] end
            column :license_expiration_date do |ii| best_in_place ii, :license_expiration_date, :type => :input,:path =>[:admin,ii] end
          end
        end
      end
    end
  end

# Edit
  form do |f|
    f.inputs "Inventory Item" do
      f.input :organization
      f.input :faa_bar_code
      f.input :item_type
      f.input :item_description
      f.input :computer_name
      f.input :location
      f.input :manufacturer
      f.input :model_number
      f.input :serial_number
      f.input :owner
      f.input :task
      f.input :location_function
      f.input :purchase_method
      f.input :order_number
      f.input :vendor
      f.input :cost
      f.input :intended_term_of_use
      f.input :decomm_date
      f.input :purchase_date
      f.input :inventory_date
      f.input :barcode_is_in_aits, :as => :radio, :collection => [["Yes", 'Yes'], ["No", 'No']]
      f.input :warranty_expiration_date
      f.input :next_maintanence_date
      f.input :next_maintanence
      f.input :notes
      f.input :hostname
      f.input :os_name
      f.input :os_version
      f.input :ip_address
      f.submit
    end
  end

# controller
  controller do
    def create
      create! do |format|
        format.html { redirect_to admin_inventoryitems_url }
      end
    end
    def update
      update! do |format|
        format.html { redirect_to admin_inventoryitems_url }
      end
    end
  end
  
end



