class Payment < ActiveRecord::Base
  belongs_to :benefit 
  belongs_to :reader
end
