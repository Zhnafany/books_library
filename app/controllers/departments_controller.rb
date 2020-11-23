class DepartmentsController < ApplicationController
  before_filter :authorize
  
  def edit
    @department = Department.find( params[:id] )
  end

  def index
    @departments = Department.find(:all)
    @brunches = Brunch.find :all
  end

  def new
     @department = Department.new
  end
  
  def create
     @department = Department.new params[:new_department]
     @department.save
     
     redirect_to :action => "index"
  end
  
  def new_sector
    @department = Department.find params[:id]
    @sector = Sector.new
  end
  
  def create_sector
    @department = Department.find params[:id]
    @department.add_sector( params[:new_sector] )
    
    redirect_to :action => "index"
  end
  
  def new_brunch
    @brunch = Brunch.new
  end
  
  def create_brunch
    @brunch = Brunch.new params[:new_brunch]
    @brunch.save
    
    redirect_to :action => "index"
  end
end
