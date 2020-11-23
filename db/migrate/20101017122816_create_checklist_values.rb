class CreateChecklistValues < ActiveRecord::Migration
  def self.up
    create_table :checklist_values do |t|
      t.integer :value
      t.integer :checklist_id
      t.integer :sector_id
      t.integer :brunch_id
    end
  end

  def self.down
    drop_table :checklist_values
  end
end
