class EducationalInstitution < ActiveRecord::Base
  has_many :faculties
  has_many :readers
end
