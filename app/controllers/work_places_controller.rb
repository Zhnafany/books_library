class WorkPlacesController < ApplicationController
  before_filter :authorize
  
  # GET /work_places
  # GET /work_places.xml
  def index
    @work_places = WorkPlace.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @work_places }
    end
  end

  # GET /work_places/1
  # GET /work_places/1.xml
  def show
    @work_place = WorkPlace.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @work_place }
    end
  end

  # GET /work_places/new
  # GET /work_places/new.xml
  def new
    @work_place = WorkPlace.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @work_place }
    end
  end

  # GET /work_places/1/edit
  def edit
    @work_place = WorkPlace.find(params[:id])
  end

  # POST /work_places
  # POST /work_places.xml
  def create
    @work_place = WorkPlace.new(params[:work_place])

    respond_to do |format|
      if @work_place.save
        format.html { redirect_to(@work_place, :notice => 'WorkPlace was successfully created.') }
        format.xml  { render :xml => @work_place, :status => :created, :location => @work_place }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @work_place.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /work_places/1
  # PUT /work_places/1.xml
  def update
    @work_place = WorkPlace.find(params[:id])

    respond_to do |format|
      if @work_place.update_attributes(params[:work_place])
        format.html { redirect_to(@work_place, :notice => 'WorkPlace was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @work_place.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /work_places/1
  # DELETE /work_places/1.xml
  def destroy
    @work_place = WorkPlace.find(params[:id])
    @work_place.destroy

    respond_to do |format|
      format.html { redirect_to(work_places_url) }
      format.xml  { head :ok }
    end
  end
end
