class RemoveWeightFromBrunches < ActiveRecord::Migration
  def self.up
    remove_column(:brunches, :weight)
  end

  def self.down
  end
end
