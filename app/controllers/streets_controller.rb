class StreetsController < ApplicationController
  before_filter :authorize
  
  # GET /streets
  # GET /streets.xml
  def index
    @streets = Street.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @streets }
    end
  end

  # GET /streets/1
  # GET /streets/1.xml
  def show
    @street = Street.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @street }
    end
  end

  # GET /streets/new
  # GET /streets/new.xml
  def new
    @street = Street.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @street }
    end
  end

  # GET /streets/1/edit
  def edit
    @street = Street.find(params[:id])
  end

  # POST /streets
  # POST /streets.xml
  def create
    @street = Street.new(params[:street])

    respond_to do |format|
      if @street.save
        format.html { redirect_to(@street, :notice => 'Street was successfully created.') }
        format.xml  { render :xml => @street, :status => :created, :location => @street }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @street.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /streets/1
  # PUT /streets/1.xml
  def update
    @street = Street.find(params[:id])

    respond_to do |format|
      if @street.update_attributes(params[:street])
        format.html { redirect_to(@street, :notice => 'Street was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @street.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /streets/1
  # DELETE /streets/1.xml
  def destroy
    @street = Street.find(params[:id])
    @street.destroy

    respond_to do |format|
      format.html { redirect_to(streets_url) }
      format.xml  { head :ok }
    end
  end
end
