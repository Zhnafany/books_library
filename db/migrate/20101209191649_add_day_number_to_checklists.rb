class AddDayNumberToChecklists < ActiveRecord::Migration
  def self.up
    add_column :checklists, :day_number, :integer
  end

  def self.down
    remove_column :checklists, :day_number
  end
end
