class AddStreetIdToContacts < ActiveRecord::Migration
  def self.up
    add_column(:contacts, :street_id, :integer)
  end

  def self.down
    remove_column(:contacts, :street_id)
  end
end
