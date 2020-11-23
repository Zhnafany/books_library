class PaymentsController < ApplicationController
  before_filter :authorize
  
  def index
    @payments = Payment.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @payments }
    end
  end

  # GET /payments/1
  # GET /payments/1.xml
  def show
    @payment = Payment.find(params[:id])
    @reader = @payment.reader

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @payments }
    end
  end

  # GET /payments/new
  # GET /payments/new.xml
  def pay
    @reader = Reader.find(params[:id])
    @payment = Payment.new
    discount = @reader.benefit.discount
    
    price = Price.find(:last, :order => 'created_at ASC').price
    @sum = price - (price * discount).div(100)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @payment }
    end
  end

  def create
    @payment = Payment.new(params[:payment])
    @reader = Reader.find(params[:id])
    @payment.benefit_id = @reader.benefit_id
    sum = params[:payment][:money_sum].to_f
    @payment.money_sum = sum
    
    @reader.payments.push(@payment)

    respond_to do |format|
        flash[:pay] = "Переєстрацію здійснено"
        format.html { redirect_to(:controller => "library", :id => @reader) }
        format.xml  { render :xml => @payment, :status => :created, :location => @payment }
      
    end
  end


end
