class Event < ActiveRecord::Base
  
  has_and_belongs_to_many :departments
  
  validates_numericality_of :count, :message => "В полі \"Кількість слухачів\" дозваляются тільки числа"
  validates_presence_of(:name, :message => "Поле \"Назва заходу\" пусте")
  validates_presence_of(:count, :message => "Поле \"Кількість слухачів\" пусте")
  
  before_destroy :destroy_relations
  
  def destroy_relations
    ActiveRecord::Base.connection.execute("delete from departments_events where event_id = #{self.id};")
  end
  
end
