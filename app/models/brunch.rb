class Brunch < ActiveRecord::Base
  has_many :checklists_value
  
  validates_uniqueness_of :name
  validates_presence_of :name
end
