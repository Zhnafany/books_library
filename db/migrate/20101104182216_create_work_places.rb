class CreateWorkPlaces < ActiveRecord::Migration
  def self.up
    create_table :work_places do |t|
      t.string :name, :limit => 30

    end
  end

  def self.down
    drop_table :work_places
  end
end
