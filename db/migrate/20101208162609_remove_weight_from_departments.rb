class RemoveWeightFromDepartments < ActiveRecord::Migration
  def self.up
    remove_column(:departments, :weight)
  end

  def self.down
  end
end
