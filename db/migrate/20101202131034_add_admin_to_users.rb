class AddAdminToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :admin, :enum, :limit => ["yes", "no"], :default=> "no"
  end

  def self.down
    remove_column :users, :admin
  end
end
