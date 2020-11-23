# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101209191649) do

  create_table "benefits", :force => true do |t|
    t.integer "discount"
    t.string  "description", :limit => 40
  end

  create_table "brunches", :force => true do |t|
    t.string "name"
  end

  create_table "categories", :force => true do |t|
    t.string "code",        :limit => 10
    t.string "description", :limit => 40
  end

  create_table "checklist_values", :force => true do |t|
    t.integer "value"
    t.integer "checklist_id"
    t.integer "sector_id"
    t.integer "brunch_id"
  end

  create_table "checklists", :force => true do |t|
    t.enum     "filed",      :limit => [:так, :ні],                           :default => :ні
    t.enum     "status",     :limit => [:виданний, :повернений], :default => :виданний
    t.integer  "reader_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "day_number"
  end

  create_table "cities", :force => true do |t|
    t.string "name", :limit => 30
  end

  add_index "cities", ["name"], :name => "name_index", :unique => true

  create_table "contacts", :force => true do |t|
    t.integer "region_id"
    t.string  "flat_number"
    t.string  "post_code",        :limit => 15
    t.string  "phone1",           :limit => 15
    t.string  "phone2",           :limit => 15
    t.string  "phone3",           :limit => 15
    t.string  "e_mail1",          :limit => 30
    t.string  "e_mail2",          :limit => 30
    t.enum    "const_work_place", :limit => [:так, :ні], :default => :ні
    t.integer "reader_id"
    t.integer "city_id"
    t.integer "street_id"
    t.integer "work_place_id"
    t.string  "house_number"
  end

  add_index "contacts", ["reader_id"], :name => "reader_id_index", :unique => true

  create_table "degrees", :force => true do |t|
    t.string "degree", :limit => 20
  end

  create_table "departments", :force => true do |t|
    t.string "name", :limit => 30
  end

  create_table "departments_events", :id => false, :force => true do |t|
    t.integer "department_id"
    t.integer "event_id"
  end

  create_table "educational_institutions", :force => true do |t|
    t.string "name",        :limit => 30
    t.string "description", :limit => 40
  end

  create_table "events", :force => true do |t|
    t.string   "name",       :limit => 40
    t.integer  "count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "faculties", :force => true do |t|
    t.string  "name",                       :limit => 30
    t.integer "educational_institution_id"
    t.string  "description",                :limit => 40
  end

  add_index "faculties", ["name"], :name => "name_index"

  create_table "payments", :force => true do |t|
    t.string   "user_name",        :limit => 15
    t.integer  "benefit_id"
    t.decimal  "money_sum",                                                                                                                                                                                                  :precision => 4, :scale => 2
    t.integer  "reader_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.enum     "new_registration", :limit => [:"\320\275\320\276\320\262\320\260 \321\200\320\265\321\224\321\201\321\202\321\200\320\260\321\206\321\226\321\217", :перереєстрація, :відновлення],                               :default => :"\320\275\320\276\320\262\320\260 \321\200\320\265\321\224\321\201\321\202\321\200\320\260\321\206\321\226\321\217"
  end

  create_table "prices", :force => true do |t|
    t.decimal  "price",      :precision => 6, :scale => 2, :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "readers", :force => true do |t|
    t.string   "surname",                    :limit => 30
    t.string   "name",                       :limit => 30
    t.string   "father_name",                :limit => 30
    t.date     "birthdate"
    t.enum     "document_type",              :limit => [:паспорт, :"\321\201\321\202\321\203\320\264\320\265\320\275. \320\272\320\262\320\270\321\202\320\276\320\272"], :default => :паспорт
    t.string   "document_num",               :limit => 20
    t.integer  "benefit_id"
    t.integer  "category_id"
    t.integer  "course"
    t.integer  "degree_id"
    t.integer  "status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.enum     "debtor",                     :limit => [:так, :ні],                                                                                                         :default => :ні
    t.integer  "faculty_id"
    t.integer  "educational_institution_id"
  end

  add_index "readers", ["father_name"], :name => "father_name_index"
  add_index "readers", ["name"], :name => "name_index"
  add_index "readers", ["surname", "name", "father_name"], :name => "surname"
  add_index "readers", ["surname"], :name => "surname_index"

  create_table "regions", :force => true do |t|
    t.string "name", :limit => 30
  end

  create_table "sectors", :force => true do |t|
    t.string  "name",          :limit => 20
    t.integer "department_id"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "statuses", :force => true do |t|
    t.string "description", :limit => 40
  end

  create_table "streets", :force => true do |t|
    t.string "name", :limit => 40
  end

  add_index "streets", ["name"], :name => "name_index", :unique => true, :length => {"name"=>"30"}

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "hashed_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.enum     "admin",           :limit => [:yes, :no], :default => :no
  end

  create_table "work_places", :force => true do |t|
    t.string "name", :limit => 30
  end

  add_index "work_places", ["name"], :name => "name_index", :unique => true

end
