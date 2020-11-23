class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string :region, :limit => 30  
      t.integer :house_number
      t.integer :flat_number
      t.string :post_code, :limit => 15
      t.string :phone1, :limit => 15
      t.string :phone2, :limit => 15
      t.string :phone3, :limit => 15
      t.string :e_mail1, :limit => 30
      t.string :e_mail2, :limit => 30
      t.enum :const_work_place, :limit => ["так","ні"], :default => "ні"
      t.integer :reader_id

    end
  end

  def self.down
    drop_table :contacts
  end
end
