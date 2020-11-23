class AddDebtorToReaders < ActiveRecord::Migration
  def self.up
    add_column :readers, :debtor, :enum, :limit => ["так", "ні"], :default=> "ні"
  end

  def self.down
    remove_column :readers, :deptor
  end
end
