class DepartmentsEvents < ActiveRecord::Migration
  def self.up
    create_table :departments_events do |t|
      t.integer :department_id
      t.integer :event_id
    end
  end

  def self.down
    drop_table :departments_events
  end
end
