class ReadersController < ApplicationController

  before_filter :authorize

  auto_complete_for :reader, :name
  auto_complete_for :reader, :surname
  auto_complete_for :reader, :father_name
  auto_complete_for :street, :name
  auto_complete_for :city, :name
  auto_complete_for :region, :name
  auto_complete_for :educational_institution, :name
  auto_complete_for :faculty, :name
  auto_complete_for :work_place, :name

  def index
    redirect_to :action => "list"
  end

  def show
    @reader = Reader.find(params[:id])
    @contact = @reader.contact
    @benefits = Benefit.find(:all)
    @categories = Category.find(:all)
    @degreies = Degree.find(:all)
    @statuses = Status.find(:all)

    @payment_status = false
    unless @reader.payments.nil?
      @payment = @reader.payments.last
      if @payment.nil?
      @payment_status = false
      else
      @payment_status = @payment.created_at.year < Date.today.year ? false : true

      end
    end

    @ticket_number = @reader.id
    @edu = @reader.educational_institution.nil? ? "" : @reader.educational_institution.name
    @faculty = @reader.faculty.nil? ? "" : @reader.faculty.name
    @region = @contact.region.nil? ? "" : @contact.region.name
    @city = @contact.city.nil? ? "" : @contact.city.name
    @street = @contact.street.nil? ? "" : @contact.street.name
    @region = @contact.region.nil? ? "" : @contact.region.name
    @work_place = @contact.work_place.nil? ? "" : @contact.work_place.name

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @reader }
    end
  end

  def new
    @reader = Reader.new
    @contact = Contact.new
    @benefits = Benefit.find(:all)
    @categories = Category.find(:all)
    @degreies = Degree.find(:all)
    @statuses = Status.find(:all)

    @ticket_number = Reader.find(:last).id + 1
    @surname = params[:reader].nil? || params[:reader][:surname] == "" ? "" : params[:reader][:surname]
    @name = params[:reader].nil? || params[:reader][:name] == "" ? "" : params[:reader][:name]
    @father_name = params[:reader].nil? || params[:reader][:father_name] == "" ? "" : params[:reader][:father_name]
    @day = params[:day].nil? || params[:day] == "" || params[:day].to_i > 31 ? DateTime.now.day.to_s : params[:day] 
    @month = params[:month].nil? || params[:month] == "" || params[:month].to_i > 12 ? DateTime.now.month.to_s : params[:month] 
    @year = params[:year].nil? || params[:year] == "" || params[:year].length > 4 ? DateTime.now.year.to_s : params[:year]

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @reader }
    end
  end

  def edit
    @reader = Reader.find(params[:id])
    @contact = @reader.contact
    @benefits = Benefit.find(:all)
    @categories = Category.find(:all)
    @degreies = Degree.find(:all)
    @statuses = Status.find(:all)

    @payment_status = false
    unless @reader.payments.nil?
      @payment = @reader.payments.last  
     unless @payment.nil?
      @payment_status = @payment.created_at.year < Date.today.year ? false : true
     else 
      @payment_status = false;
     end 
    end

    @ticket_number = @reader.id
    @edu = @reader.educational_institution.nil? ? "" : @reader.educational_institution.name
    @faculty = @reader.faculty
    @region =  @contact.region
    @city =  @contact.city
    @street =  @contact.street
    @region = @contact.region
    @work_place =  @contact.work_place

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @reader }
    end
  end

  def create
    @benefits = Benefit.find(:all)
    @categories = Category.find(:all)
    @degreies = Degree.find(:all)
    @statuses = Status.find(:all)
    @ticket_number = Reader.find(:last).id + 1

    @educational_institution = EducationalInstitution.find(:first,
         :conditions => "name = '#{params[:educational_institution][:name]}'")
    @edu.nil? ? @edu = EducationalInstitution.create(
      :name => params[:educational_institution][:name]) : @educational_institution
    @faculty = Faculty.find(:first, :conditions => "name = '#{params[:faculty][:name]}'")
    @faculty.nil? ? @faculty = Faculty.create(:name => params[:faculty][:name]) : @faculty
    @work_place = WorkPlace.find(:first, :conditions => "name = '#{params[:work_place][:name]}'")
    @work_place.nil? ? @work_place = WorkPlace.create(:name => params[:work_place][:name]) : @work_place
    @city = City.find(:first, :conditions => "name = '#{params[:city][:name]}'")
    @city.nil? ? @city = City.create(:name => params[:city][:name]) : @city
    @street = Street.find(:first, :conditions => "name = '#{params[:street][:name]}'")
    @street.nil? ? @street = Street.create(:name => params[:street][:name]) : @street
    @region = Region.find(:first, :conditions => "name = '#{params[:region][:name]}'")
    @region.nil? ? @region = Region.create(:name => params[:region][:name]) : @region

    @reader = Reader.new(params[:reader])
    @contact = Contact.new(params[:contact])
    @educational_institution.readers.push @reader unless @educational_institution.nil? 
    @faculty.readers.push @reader unless @faculty.nil? 
    @city.contacts.push @contact unless @city.nil? 
    @street.contacts.push @contact unless @street.nil?
    @region.contacts.push @contact unless @region.nil?
    @ork_place.contacts.push @contact unless @ork_place.nil?
    @reader.contact = @contact

    respond_to do |format|
      if @reader.save && @reader.contact.save
        flash[:new] = "Читач створений"
        format.html { redirect_to(:controller => "readers",
                                  :action => "take_photo", :id => @reader, :new => 1)}
        format.xml  { render :xml => @reader, :status => :created, :location => @reader }
      else
        @errors = @reader.errors
        format.html { render :action => "new"}
        format.xml  { render :xml => @reader.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /readers/1
  # PUT /readers/1.xml
  def update

    edu = EducationalInstitution.find(:first, :conditions => "name = '#{params[:educational_institution][:name]}'")
    edu.nil? ? edu = EducationalInstitution.create(:name => params[:educational_institution][:name]) : edu
    faculty = Faculty.find(:first, :conditions => "name = '#{params[:faculty][:name]}'")
    faculty.nil? ? faculty = Faculty.create(:name => params[:faculty][:name]) : faculty
    work_place = WorkPlace.find(:first, :conditions => "name = '#{params[:work_place][:name]}'")
    work_place.nil? ? work_place = WorkPlace.create(:name => params[:work_place][:name]) : work_place
    city = City.find(:first, :conditions => "name = '#{params[:city][:name]}'")
    city.nil? ? city = City.create(:name => params[:city][:name]) : city
    street = Street.find(:first, :conditions => "name = '#{params[:street][:name]}'")
    street.nil? ? street = Street.create(:name => params[:street][:name]) : street
    region = Region.find(:first, :conditions => "name = '#{params[:region][:name]}'")
    region.nil? ? region = Region.create(:name => params[:region][:name]) : region

    @reader = Reader.find(params[:id])
    @contact = @reader.contact
    edu.readers.push @reader unless edu.nil? 
    faculty.readers.push @reader unless faculty.nil? 
    city.contacts.push @contact unless city.nil? 
    street.contacts.push @contact unless street.nil?
    region.contacts.push @contact unless region.nil?
    work_place.contacts.push @contact unless work_place.nil?
    @reader.contact  = @contact 

    respond_to do |format|

      if @reader.update_attributes(params[:reader]) && @contact.update_attributes(params[:contact])  
        flash[:edit] = "Читач відредагований"
        format.html { redirect_to(:controller => "library", :action => "search", :id => @reader)}
        format.xml  { head :ok }
      else
        format.html { redirect_to :action => "edit", :id => @reader}
        format.xml  { render :xml => @reader.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /readers/1
  # DELETE /readers/1.xml
  def destroy
    @reader = Reader.find(params[:id])
    @reader.destroy

    respond_to do |format|
      format.html { redirect_to(readers_url) }
      format.xml  { head :ok }
    end
  end

  def debtor_list
    @debtors = Reader.find(:all, :conditions => "debtor='так'", :order => "surname ASC")

    @debtors = @debtors.paginate(:page => params[:page], :order => 'surname ASC', :per_page => 30) unless @debtors.nil?
  end

  def list
    if params[:search] == "true"
     name = params[:reader][:name] == "" ? "" : "name like '#{params[:reader][:name]}%',"
     surname = params[:reader][:surname] == "" ? "" : "surname like '#{params[:reader][:surname]}%',"
     father_name = params[:reader][:father_name] == "" ? "" : "father_name like '#{params[:reader][:father_name]}%',"
     birthdate = "birthdate = '#{params[:year]}-#{params[:month]}-#{params[:day]}'"
       mystr = params[:year].to_s.strip+"-"+params[:month].to_s.strip + "-"+params[:day].to_s.strip
     if mystr.strip =~ /\d\d\d\d-\d+-\d+/
        @readers = Reader.find(:all, :conditions => 
                     ['name LIKE ? AND surname LIKE ? AND father_name LIKE ? AND birthdate = ?', 
                    "#{params[:reader][:name]}%", "#{params[:reader][:surname]}%",
                    "#{params[:reader][:father_name]}%", mystr.strip], :order => "surname ASC", :limit => 200)
     else
        @readers = Reader.find(:all, :conditions => 
                     ['name LIKE ? AND surname LIKE ? AND father_name LIKE ?', 
                    "#{params[:reader][:name]}%", "#{params[:reader][:surname]}%",
                    "#{params[:reader][:father_name]}%"], :order => "surname ASC", :limit => 200)
     end

        @readers = @readers.paginate :page => params[:page], :order => 'surname ASC', :per_page => 30
    else
      @readers = Reader.paginate :page => params[:page], :order => 'surname ASC', :per_page => 30
    end
    render :layout => false
  end

  def take_photo
    @reader = Reader.find(params[:id])
  end

  def save_photo
    name =  params[:id]
    path = File.join(Reader.photos_directory, name + '.jpg')
    File.open(path, "wb") { |f| f.write request.body.read }
    render :text => "File has been uploaded successfully"
  end

  def auto_complete_for_reader_name
    @readers = Reader.find_by_sql([" SELECT DISTINCT name 
                                    FROM readers
                                    WHERE name LIKE ? 
                                    LIMIT 0,8", params[:reader][:name]+'%'])
    render :inline => "<%= content_tag(:ul, @readers.map {|r| content_tag(:li, h(r.name)) }) %>"
  end

  def auto_complete_for_reader_surname
    @readers = Reader.find_by_sql([" SELECT DISTINCT surname 
                                    FROM readers
                                    WHERE surname LIKE ? 
                                    LIMIT 0,8", params[:reader][:surname]+'%'])
    render :inline => "<%= content_tag(:ul, @readers.map {|r| content_tag(:li, h(r.surname)) }) %>"
  end

  def auto_complete_for_reader_father_name
    @readers = Reader.find_by_sql([" SELECT DISTINCT father_name 
                                    FROM readers
                                    WHERE father_name LIKE ? 
                                    LIMIT 0,8", params[:reader][:father_name]+'%'])
    render :inline => "<%= content_tag(:ul, @readers.map {|r| content_tag(:li, h(r.father_name)) }) %>"
  end

  def auto_complete_for_educational_institution_name
    @edu = EducationalInstitution.find_by_sql ["SELECT DISTINCT *
                                                 FROM educational_institutions
                                                 WHERE name LIKE ?
                                                 LIMIT 0,7", params[:educational_institution][:name]+'%']
    render :inline => "<%= content_tag(:ul, @edu.map {|e| content_tag(:li, h(e.name)) }) %>"
  end

  def auto_complete_for_faculty_name
    @faculties = Faculty.find_by_sql ["SELECT DISTINCT *
                                       FROM faculties
                                       WHERE name LIKE ?
                                       LIMIT 0,7", params[:faculty][:name]+'%']
    render :inline => "<%= content_tag(:ul, @faculties.map {|f| content_tag(:li, h(f.name)) }) %>"
  end

  def auto_complete_for_region_name
    @regions = Faculty.find_by_sql ["SELECT DISTINCT *
                                       FROM regions
                                       WHERE name LIKE ?
                                       LIMIT 0,7", params[:region][:name]+'%']
    render :inline => "<%= content_tag(:ul, @regions.map {|r| content_tag(:li, h(r.name)) }) %>"
  end

  def auto_complete_for_street_name
    @streets = Faculty.find_by_sql ["SELECT DISTINCT *
                                       FROM streets
                                       WHERE name LIKE ?
                                       LIMIT 0,7", params[:street][:name]+'%']
    render :inline => "<%= content_tag(:ul, @streets.map {|s| content_tag(:li, h(s.name)) }) %>"
  end

  def auto_complete_for_city_name
    @cities = Faculty.find_by_sql ["SELECT DISTINCT *
                                       FROM cities
                                       WHERE name LIKE ?
                                       LIMIT 0,7", params[:city][:name]+'%']
    render :inline => "<%= content_tag(:ul, @cities.map {|c| content_tag(:li, h(c.name)) }) %>"
  end

  def auto_complete_for_work_place_name
    @work_places = Faculty.find_by_sql ["SELECT DISTINCT *
                                       FROM work_places
                                       WHERE name LIKE ?
                                       LIMIT 0,7", params[:work_place][:name]+'%']
    render :inline => "<%= content_tag(:ul, @work_places.map {|w| content_tag(:li, h(w.name)) }) %>"
  end

end
