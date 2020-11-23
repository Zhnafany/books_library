class AddWeightToDepartments < ActiveRecord::Migration
  def self.up
    add_column :departments, :weight, :integer
  end

  def self.down
    remove_column :departments, :weight
  end
end
