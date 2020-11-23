class Contact < ActiveRecord::Base
  belongs_to :reader
  belongs_to :city
  belongs_to :street
  belongs_to :work_place
  belongs_to :region
  
  before_destroy :remove_city
  
  validates_columns :const_work_place
  
  def remove_city
    self.city.destroy
  end
  
end
