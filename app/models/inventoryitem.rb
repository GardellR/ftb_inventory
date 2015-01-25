#test
class Inventoryitem < ActiveRecord::Base
  belongs_to :ftbsystemtype
  has_many :inventoryitem_softwares, dependent: :destroy
  has_many :softwares, :through => :inventoryitem_softwares
  has_many :virtualinstances, dependent: :destroy

#  scope :ang_c5, -> { where(organization: 'ANG-C5') }
#  scope :ang_c4, -> { where(organization: 'ANG-C4') }
  scope :systems, -> { where(item_type: ['server']) }
#  scope :systems, -> { where(item_type: ['systems', 'computer', 'server']) }
  scope :will_expire_60, lambda { where(   "warranty_expiration_date < ?", Date.today+60.days) }

  def display_name
    faa_bar_code
  end

### below is not part of the model
  
  def Inventoryitem.empty_models
    Inventoryitem.all.collect{|a| a.destroy}
    InventoryitemSoftware.all.collect{|a| a.destroy}
    Software.all.collect{|a| a.destroy}
    Virtualinstance.all.collect{|a| a.destroy}
    Ftbsystemtype.all.collect{|a| a.destroy}
  end

  def Inventoryitem.iii
    iii = Inventoryitem.new
    iii.save
    Inventoryitem.all.size
  end

  def Inventoryitem.create_from_import(iii)
    ii = Inventoryitem.new
    ii.organization = iii.organization
    ii.faa_bar_code = iii.faa_bar_code
    ii.item_type = iii.item_type
    ii.item_description = iii.item_description
    ii.computer_name = iii.computer_name
    ii.location = iii.location_1
    ii.manufacturer = iii.manufacturer
    ii.model_number = iii.part_no
    ii.serial_number = iii.serial_no[0..250]
    ii.owner = iii.ftb_owner
    ii.task = iii.task
    ii.location_function = iii.location_2
    ii.purchase_method = iii.purchase_method
    ii.order_number = iii.order_number
    ii.vendor = iii.vendor
    ii.cost = iii.cost
    ii.intended_term_of_use = iii.intended_term_of_Use
    ii.decomm_date = iii.decomm_date
    ii.purchase_date = iii.purchase_date
    ii.barcode_is_in_aits = iii.barcode_in_aits
    ii.notes = iii.notes + ' --- ' + iii.additional_notes + ' --- ' + iii.ftb_comments + ' --- ' + iii.je_comments + ' --- ' + iii.may_6_2014_comments + ' --- ' + iii.may_20
    ii.ip_address = iii.ip_Address
    fst = Ftbsystemtype.find_or_create_by(name: iii.ftb_system)
    fst.save
    ii.ftbsystemtype = fst
    ii.save
  end

  def Inventoryitem.add_software
    fst = Ftbsystemtype.find_by_name('ERAM')
    fst.description = "En Route Automation Modernization (ERAM) replaces the 40-year-old En Route Host computer"
    fst.save

    fst = Ftbsystemtype.find_by_name('SDSS Hardware')
    fst.description = "The objectives of the Louisville SDSS project are to identify, prototype, and validate advanced Surface Traffic Management capabilities"
    fst.save

    ii = fst.inventoryitems.select{|a| a.item_type == 'Computer'}[0]
    ii.warranty_expiration_date = "2014-01-02"
    ii.save
    ii = fst.inventoryitems.select{|a| a.item_type == 'Computer'}[1]
    ii.warranty_expiration_date = "2014-12-25"
    ii.save
    ii = fst.inventoryitems.select{|a| a.item_type == 'Server'}[0]
    ii.warranty_expiration_date = "2016-01-02"
    ii.save
    ii2 = Inventoryitem.all[2]
    se = Software.new
    se.software_name = 'Excel'
    se.software_version = '2010'
    se.save
    sw = Software.new
    sw.software_name = 'Word'
    sw.software_version = '2010'
    sw.save
    sp = Software.new
    sp.software_name = 'Powerpoint'
    sp.software_version = '2013'
    sp.save
    iis = InventoryitemSoftware.new
    iis.license_number = '111'
    iis.license_expiration_date = 'Dec 25 2014'
    iis.instalation_date = 'Dec 25 2015'
    iis.software = sp
    iis.inventoryitem = ii
    iis.save
    iis = InventoryitemSoftware.new
    iis.license_number = '222'
    iis.license_name = 'personal'
    iis.license_type = 'academic'
    iis.license_expiration_date = 'April 25 2015'
    iis.instalation_date = 'Dec 25 2015'
    iis.software = se
    iis.inventoryitem = ii
    iis.save
    iis = InventoryitemSoftware.new
    iis.license_number = '333'
    iis.license_name = 'personal'
    iis.license_type = 'academic'
    iis.license_expiration_date = 'April 25 2015'
    iis.instalation_date = 'Dec 25 2015'
    iis.software = se
    iis.inventoryitem = ii2
    iis.save
    iis = InventoryitemSoftware.new
    iis.license_number = '889'
    iis.license_name = 'individual'
    iis.license_type = 'academic'
    iis.license_expiration_date = 'Nov 25 2014'
    iis.instalation_date = 'Dec 25 2014'
    iis.software = sw
    iis.inventoryitem = ii
    iis.save
  end
  
  def Inventoryitem.import_all
    Inventoryitem.empty_models
#    InventoryItemsImport.all.collect do |iii|
    InventoryItemsImport.all[0..200].collect do |iii|
      Inventoryitem.create_from_import(iii)
    end
    Inventoryitem.add_software
    
  end
end
