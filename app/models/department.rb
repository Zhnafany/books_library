class Department < ActiveRecord::Base
  has_many :sectors
  before_destroy :destroy_sectors
  has_and_belongs_to_many :events
  
  validates_uniqueness_of :name
  validates_presence_of :name
  
  before_save do |dep|
      sector = Sector.new(:name => dep.name)
      dep.sectors.push sector
  end
  
  def destroy_sectors
    self.sectors.each{|sec| sec.destroy}
  end
  
  def add_sector params
    self.sectors.find_by_name(self.name).destroy if self.sectors.inject(0){|res, sec| res = 1 if self.name.eql? sec.name }
    sector = Sector.new params
    self.sectors.push sector
  end
end
