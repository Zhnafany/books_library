class Checklist < ActiveRecord::Base
  has_many :checklist_values
  belongs_to :reader
  
  before_destroy :destroy_checklist_values
  
  def destroy_checklist_values
    self.checklist_values.each{|x| x.destroy}
  end
  
end
