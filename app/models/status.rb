class Status < ActiveRecord::Base
  has_many :readers
  
  validates_uniqueness_of :description
  validates_presence_of :description
end
