class ChangeHouseNumberFromContacts < ActiveRecord::Migration
  def self.up
    remove_column :contacts, :house_number
    add_column :contacts, :house_number, :string 
  end

  def self.down
    remove_column :contacts, :house_number
  end
end
