class CreateFtbsystemtypes < ActiveRecord::Migration
  def change
    create_table :ftbsystemtypes do |t|
      t.string :name
      t.text :description
      t.string :purpose

      t.timestamps
    end
  end
end
