class LibraryController < ApplicationController
  before_filter :authorize

  auto_complete_for :reader, :name
  auto_complete_for :reader, :surname
  auto_complete_for :reader, :father_name


  def index
    unless params[:id].nil? || params[:id] == ""
      @reader = Reader.find :first, :conditions => "id =  #{params[:id]}"
        unless @reader.nil?  
          @checklist =  Checklist.find(:last)
          @ticket_number = @reader.nil? ? "" : @reader.id
       end
   end
   session[:back] = "index"
  end

  def submit_requests

  end

  def search
    unless params[:id].nil?
      @reader = Reader.find params[:id]
    end

    @fields = ['reader_surname', 'reader_name', 'reader_father_name', 'day', 'month', 'year']
  end

  def reader_info
    unless params[:id] == "" || params[:id].nil?
      @reader = Reader.find_by_id params[:id]
      unless @reader.nil?
        @payment_status = false
        @bookkeep = false
        @bookkeep = true if @reader.debtor == :так
        @payment_status = true if @reader.payments.any? && @reader.payments.last.created_at.year == DateTime.now.year
        @fotoButton = @reader.FotoExist?
      end
    end
    render :layout => false
  end

  def debtor_info
    unless params[:id] == "" || params[:id].nil?
      @reader = Reader.find_by_id params[:id]
      @bookkeep = false
      @bookkeep = true if @reader.debtor == :так
   end
    render :layout => false
  end

  def search_debtors
    unless params[:id].nil?
      @reader = Reader.find params[:id]
      @ticket_number = @reader.nil? ? "" : @reader.id
    end
    session[:back] = "search_debtors"
  end

  def make_debtor
    @reader = Reader.find(params[:id])
    @reader.debtor = :так
    @reader.save
    flash[:new] = "Встановлено статус \"Боржник\""

    redirect_to :action => session[:back], :id => @reader
  end

  def remove_from_debtor
    @reader = Reader.find( params[:id] )
    @reader.debtor = :ні
    @reader.save
    flash[:new] = "Знято статус \"Боржник\""

    redirect_to :action => session[:back], :id => @reader
  end

  def print_reader_ticket
    @reader = Reader.find params[:id]
    @reader.generateReaderTicket
    #send_file 'public/images/curent_reader_ticket.png', :type => 'image/png', :disposition => 'inline'
    render :layout => false
  end

  def auto_complete_for_reader_name
    @readers = Reader.find_by_sql(["SELECT DISTINCT name 
                                    FROM readers
                                    WHERE name LIKE ? 
                                    LIMIT 0,8", params[:reader][:name]+'%'])
    render :inline => "<%= content_tag(:ul, @readers.map {|r| content_tag(:li, h(r.name)) }) %>"
  end

  def auto_complete_for_reader_surname
    @readers = Reader.find_by_sql(["SELECT DISTINCT surname 
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

end
