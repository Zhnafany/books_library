class CreatePayments < ActiveRecord::Migration
  def self.up
    create_table :payments do |t|   
      t.string :user_name, :limit => 15
      t.integer :benefit_id
      t.decimal :money_sum, :precision => 4, :scale => 2
      t.integer :reader_id

      t.timestamps
    end
  end

  def self.down
    drop_table :payments
  end
end
