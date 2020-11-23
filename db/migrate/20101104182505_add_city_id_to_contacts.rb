class AddCityIdToContacts < ActiveRecord::Migration
  def self.up
    add_column(:contacts, :city_id, :integer)
  end

  def self.down
    remove_column(:contacts, :city_id)
  end
end
