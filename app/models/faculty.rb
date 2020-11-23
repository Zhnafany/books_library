class Faculty < ActiveRecord::Base
  belongs_to :educational_institution
  has_many :readers
end
