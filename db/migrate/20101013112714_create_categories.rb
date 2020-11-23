class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :code, :limit => 10
      t.string :description, :limit => 40

    end
  end

  def self.down
    drop_table :categories
  end
end
