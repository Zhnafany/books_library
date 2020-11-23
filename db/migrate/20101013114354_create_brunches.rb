class CreateBrunches < ActiveRecord::Migration
  def self.up
    create_table :brunches do |t|
      t.string :name, :limit => 30

    end
  end

  def self.down
    drop_table :brunches
  end
end
