class EventsController < ApplicationController
  before_filter :authorize
  # GET /events
  # GET /events.xml
  def index
    @events = Event.find(:all, :order => "created_at DESC").paginate(:page => 
                            params[:page], :order => "created_at DESC", :per_page => 30)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
    end
  end

  # GET /events/new
  # GET /events/new.xml
  def new
    @departs = Department.find :all, :order => "name ASC"
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.xml
  def create
    @event = Event.new
    @event.name = params[:new_event][:name]
    @event.count = params[:new_event][:count].to_i
      values = params[:departments] 
      values.each{|key, value| 
        @event.departments.push( Department.find(key.to_i) ) if value == "1" }
    
    respond_to do |format|
      if @event.save
        format.html { redirect_to(:action => "index", :notice => 'Event was successfully created.') }
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        format.html { redirect_to :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.xml
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to(:action => "index", :notice => 'Event was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to(:action => "index") }
      format.xml  { head :ok }
    end
  end
end
