class CreateBenefits < ActiveRecord::Migration
  def self.up
    create_table :benefits do |t|
      t.integer :discount
      t.string :description, :limit => 40

    end
  end

  def self.down
    drop_table :benefits
  end
end
