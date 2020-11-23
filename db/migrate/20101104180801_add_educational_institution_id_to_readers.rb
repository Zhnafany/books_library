class AddEducationalInstitutionIdToReaders < ActiveRecord::Migration
  def self.up
    add_column(:readers, :educational_institution_id, :integer)
  end

  def self.down
    remove_column(:readers, :educational_institution_id)
  end
end
