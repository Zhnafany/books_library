class AddWorkPlaceIdToContacts < ActiveRecord::Migration
  def self.up
    add_column(:contacts, :work_place_id, :integer)
  end

  def self.down
    remove_column(:contacts, :work_place_id)
  end
end
