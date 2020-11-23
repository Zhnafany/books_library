class CreatePrices < ActiveRecord::Migration
  def self.up
    create_table :prices do |t|
      t.decimal :price, :precision => 6, :scale => 2, :default => 0
      
      t.timestamps
    end
  end

  def self.down
    drop_table :prices
  end
end
