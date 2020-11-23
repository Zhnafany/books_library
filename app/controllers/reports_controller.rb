class ReportsController < ApplicationController
  layout "reports", :except => ["index", "manage"]

  def index
    render :layout => "application"  
  end

  def manage

    if params[:period] == "interval"
      @from = Date.civil(params[:interval]["from(1i)"].to_i, params[:interval]["from(2i)"].to_i, params[:interval]["from(3i)"].to_i)
      @to = Date.civil(params[:interval]["to(1i)"].to_i, params[:interval]["to(2i)"].to_i, params[:interval]["to(3i)"].to_i)
    elsif params[:period] == "day"
      @from = Date.civil(params[:day]["selected(1i)"].to_i, params[:day]["selected(2i)"].to_i, params[:day]["selected(3i)"].to_i)
      @to = @from
    elsif params[:period] == "month"
      @to = Date.civil(Date.today.year, params[:date][:month].to_i, -1)
      @from = Date.civil(Date.today.year, params[:date][:month].to_i)
    elsif params[:quarter]
      if params[:quarter] == "1"
        @from = Date.civil( Date.today.year, 01 , 1 )
        @to = Date.civil( Date.today.year, 03, -1 )
      elsif params[:quarter] == "2"
        @from = Date.civil( Date.today.year, 04, 1 )
        @to = Date.civil( Date.today.year, 06, -1 )
      elsif params[:quarter] == "3"
        @from = Date.civil( Date.today.year, 07, 1 )
        @to = Date.civil( Date.today.year, 9, -1 )
      elsif params[:quarter] == "4"
        @from = Date.civil( Date.today.year, 10, 1 )
        @to = Date.civil( Date.today.year, 12, -1 )
      end
    elsif params[:period] == "year"
      @from = Date.parse( Date.today.year.to_s + "-01-01" )
      @to = Date.today
    end
      @brunches = Brunch.find(:all, :order => "id ASC")
      @departments = Department.find(:all, :order => "id ASC")
      @values = Report.brunches_report(@from, @to)
    if params[:report] ==  "1"
       @one_reader = Report.one_reader(@from, @to)
       @catered_reader = Report.catered_reader(@from, @to)
       @visiting = Report.visiting(@from, @to)
       @bookkeeping = Report.bookkeeping(@from, @to)
       render :template => "reports/print_readers_report", :locals => {:departments => @departments, :one_reader => @one_reader, :catered_reader => @catered_reader, :bookeeping => @bookeeping, :visiting => @visiting, :brunches => @brunches}
    elsif params[:report] ==  "2"
      @names = @departments.inject([]){|res, dep| res.push( dep.name ); res.push( dep.sectors.map{|sec| sec.name } ) }
      render :template => "reports/print_brunches_report", :locals => {:departments => @departments, :values => @values, :brunches => @brunches, :names => @names}
    elsif params[:report] ==  "3"
      @sum = Report.payments_report(@from, @to)
      @payments = Payment.find_by_sql("select * from payments where created_at between '" + @from.to_s + " 00:00' and '" + @to.to_s + " 23:59';")
      render :template => "reports/print_payments_report", :locals => {:payments => @payments, :sum => @sum}

    end
  end

  def print_readers_report
    render :layout => false
  end

  def print_brunches_report
    render :layout => false
  end

  def print_payments_report
      render :layout => false
  end

end
