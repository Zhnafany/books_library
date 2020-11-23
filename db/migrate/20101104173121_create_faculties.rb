class CreateFaculties < ActiveRecord::Migration
  def self.up
    create_table :faculties do |t|
      t.string :name, :limit => 20
      t.integer :educational_institution_id
      t.string :description, :limit => 40
      
    end
  end

  def self.down
    drop_table :faculties
  end
end
