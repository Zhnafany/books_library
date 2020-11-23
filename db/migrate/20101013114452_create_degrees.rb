class CreateDegrees < ActiveRecord::Migration
  def self.up
    create_table :degrees do |t|
      t.string :degree, :limit => 20

    end
  end

  def self.down
    drop_table :degrees
  end
end
