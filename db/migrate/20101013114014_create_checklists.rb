class CreateChecklists < ActiveRecord::Migration
  def self.up
    create_table :checklists do |t|
      t.enum :filed, :limit => ["так", "ні"], :default => "ні"
      t.integer :quantity
      t.enum :status, :limit => ["виданний", "повернений"], :default => "виданний"
      t.integer :reader_id

      t.timestamps
    end
  end

  def self.down
    drop_table :checklists
  end
end
