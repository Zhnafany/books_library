class Price < ActiveRecord::Base
  
  validates_presence_of :price
  validates_numericality_of :price
  
end
