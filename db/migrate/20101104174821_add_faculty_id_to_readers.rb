class AddFacultyIdToReaders < ActiveRecord::Migration
  def self.up
    add_column(:readers, :faculty_id, :integer)
  end

  def self.down
    remove_column(:readers, :faculty_id)
  end
end
