class ChecklistsController < ApplicationController
  before_filter :authorize
    
  def new
    @brunches = Brunch.find(:all, :order => "id ASC")
    @departments = Department.find(:all, :order => "id ASC")
    
    @checklist_number = Reader.find(params[:id]).checklists.find(:first, :order => "created_at DESC", :conditions => "status = 'виданний'").day_number
    @iterator = 0
  end
  
  def create
    reader = Reader.find params[:id]
    values = params[:new_checklist]
    checklist = reader.checklists.find(:first, :order => "created_at DESC", :conditions => "status = 'виданний'")
    checklist.status = "повернений"
    values.each do |key, value|
      unless value == ""
        checklist.filed = "так"
        xy = key.scan(/[0-9]+/)
        ch_value = ChecklistValue.new
        ch_value.brunch_id = xy[0]
        ch_value.sector_id = xy[1]
        ch_value.value = value
        checklist.checklist_values.push ch_value
      end
    end
    checklist.save

    flash[:checklist] = "Контрольний талон збережено"
    if checklist.filed == :так
        redirect_to :action => "index", :id => checklist
    else
        redirect_to :controller => "library", :action => "index", :id => reader
    end
  end
  
  def give_checklist
    reader = Reader.find params[:id]
    checklist_last = Checklist.find(:last,
        :conditions => "created_at > '#{Date.today.to_s} 00:00:00'")
    checklist = Checklist.new
    checklist.day_number = checklist_last.nil? ? 1 : checklist_last.day_number  + 1 
    reader.checklists.push checklist
    
    flash[:checklist] = "Контрольний талон видано"
    redirect_to :controller => "library", :id => reader
  end

  def print_checklist
    @iterator = 0
    
    @reader = Reader.find params[:id]
    @checklist = Checklist.find(:last, :conditions => "created_at > '#{Date.today.to_s + ' 00:00:00'}'")
    unless @checklist.nil?
      @checklist_id = @checklist.day_number + 1
    else
      @checklist_id = 1
    end
    @brunches = Brunch.find(:all, :order => "id ASC")
    @departments = Department.find(:all, :order => "id ASC") 
    
    render :layout => false
  end

  def index
    @checklist = params[:id].nil? ? "" : Checklist.find(params[:id])
    @checklists = Checklist.find(:all, :conditions => "created_at > '#{Date.today.to_s + ' 00:00:00'}'")
    @checklists_filed = @checklists.find_all{|ch| ch.filed == :так }
    @checklists_empty = @checklists - @checklists_filed
    @iterator = 0
    session[:page] = "index"
  end
  
  def checklists_archive
    unless params[:date].nil?
      date = Date.civil(params[:date]["(1i)"].to_i, params[:date]["(2i)"].to_i, params[:date]["(3i)"].to_i)
      @checklists = Checklist.find(:all, :conditions => "created_at > '#{date.to_s} 00:00:00' and 
                                                          created_at < '#{date.to_s} 23:59:59'")
    else
      @checklists = Checklist.find(:all, :conditions => "created_at > '#{Date.today.to_s + ' 00:00:00'}'")
    end
    @day = date.nil? ? Date.today.day : date.day
    @month = date.nil? ? Date.today.month : date.month
    @iterator = 0
    session[:page] = "archive"
  end

  def edit
      unless params[:date].nil?
        date = Date.civil(params[:date]["(1i)"].to_i, params[:date]["(2i)"].to_i, params[:date]["(3i)"].to_i)
      else
        date = Date.today
      end
      @checklist = params[:day_number].nil? ? Checklist.find_by_id(params[:id]) :
                   checklist_number = Checklist.find(:last,
                    :conditions => "created_at > '#{date.to_s} 00:00:00' and 
                                    created_at < '#{date.to_s} 23:59:59' and 
                                    day_number = #{params[:day_number].to_i}")
      @brunches = Brunch.find(:all, :order => "id ASC")
      @departments = Department.find(:all, :order => "id ASC")

      @iterator = 0
      if @checklist.nil?
        flash[:no_checklist] = t(:there_are_no_such_checklist)
        redirect_to(:back)
      end
  end
  
  def update
    values = params[:update_checklist]
    checklist = Checklist.find params[:id]
    checklist.filed = "так"
    values.each do |key, value|
      unless value == ""
        xy = key.scan(/[0-9]+/)
        ch_value = checklist.checklist_values.find(:first,
                             :conditions => "brunch_id = '#{xy[0]}' and sector_id = '#{xy[1]}'" ).nil? ?
                             ChecklistValue.new : checklist.checklist_values.find(:first,
                             :conditions => "brunch_id = '#{xy[0]}' and sector_id = '#{xy[1]}'" )
        ch_value.brunch_id = xy[0]
        ch_value.sector_id = xy[1]
        ch_value.value = value
        checklist.checklist_values.push ch_value
      end
    end
    checklist.save
    
    flash[:checklist] = "Контрольний талон вiдредаговано"
    if session[:page] == "index"
      redirect_to :action => "index", :id => checklist
    elsif session[:page] == "archive"
      redirect_to :action => "checklists_archive"
    end
  end

  def show
  end

end
