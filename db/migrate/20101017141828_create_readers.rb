class CreateReaders < ActiveRecord::Migration
  def self.up
    create_table :readers do |t|
      t.string :surname, :limit => 30  
      t.string :name, :limit => 30
      t.string :father_name, :limit =>30
      t.date :birthdate
      t.enum :document_type, :limit => ["паспорт","студен. квиток"], :default => "паспорт"
      t.string :document_num, :limit => 20
      t.integer :benefit_id
      t.integer :category_id
      t.integer :course
      t.integer :degree_id
      t.integer :status_id  

      t.timestamps
    end
  end

  def self.down
    drop_table :readers
  end
end
