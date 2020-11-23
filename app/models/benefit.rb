class Benefit < ActiveRecord::Base
  has_many :readers
  has_many :payments
  
  validates_presence_of :discount
  validates_presence_of :description
end
