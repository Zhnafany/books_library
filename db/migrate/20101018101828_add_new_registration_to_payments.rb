class AddNewRegistrationToPayments < ActiveRecord::Migration
  def self.up
    add_column :payments, :new_registration, :enum, 
                    :limit => ["нова реєстрація", "перереєстрація","відновлення"],
                    :default => "нова реєстрація"
  end

  def self.down
    remove_column :payments, :new_registration
  end
end
