class Degree < ActiveRecord::Base
  has_many :readers
  
  validates_uniqueness_of :degree
  validates_presence_of :degree
end