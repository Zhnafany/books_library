class Category < ActiveRecord::Base
  has_many :readers
  
  validates_uniqueness_of :code
  validates_presence_of :code
  validates_presence_of :description
end
