class CreateSoftwares < ActiveRecord::Migration
  def change
    create_table :softwares do |t|
      t.string :software_name
      t.string :software_version

      t.timestamps
    end
  end
end
