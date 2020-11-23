class ChecklistValue < ActiveRecord::Base
  belongs_to :checklist
  belongs_to :brunch
  belongs_to :sector
end
