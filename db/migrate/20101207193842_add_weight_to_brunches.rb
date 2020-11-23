class AddWeightToBrunches < ActiveRecord::Migration
  def self.up
    add_column :brunches, :weight, :integer
  end

  def self.down
    remove_column :brunches, :weight
  end
end
