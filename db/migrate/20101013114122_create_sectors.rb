class CreateSectors < ActiveRecord::Migration
  def self.up
    create_table :sectors do |t|
      t.string :name, :limit => 20
      t.integer :department_id
    end
  end

  def self.down
    drop_table :sectors
  end
end
