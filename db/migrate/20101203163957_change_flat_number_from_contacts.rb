class ChangeFlatNumberFromContacts < ActiveRecord::Migration
  def self.up
    change_column(:contacts, :flat_number, :string, options = {})
  end

  def self.down
    remove_column(:contacts, :flat_number)
  end
end
