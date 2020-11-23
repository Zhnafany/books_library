class CreateEducationalInstitutions < ActiveRecord::Migration
  def self.up
    create_table :educational_institutions do |t|
      t.string :name, :limit => 30

    end
  end

  def self.down
    drop_table :educational_institutions
  end
end
