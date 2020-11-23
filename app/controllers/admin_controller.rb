class AdminController < ApplicationController
  protect_from_forgery :except => :login
  
  before_filter :authorize, :except => "login"

  def index
    
  end

  def login
    session[:user_id] = nil
    if request.post?
      user = User.authenticate(params[:username], params[:password])
      if user
        session[:user_id] = user.id
        session[:admin] = 1 if user.admin == :yes 
        uri = session[:original_uri]
        session[:original_uri] = nil
        redirect_to(uri || {:controller => "library", :action => "index" })
      else
        flash.now[:notice] = t(:invalid_user_password)
      end
    end
  end

  def logout
    @user_name = User.find(session[:user_id]).username
    session[:user_id] = nil
    session[:admin] = 0
    flash[:notice] = "<strong>#{t(:user)} <em>#{@user_name}</em> #{t(:logout_message)}</strong>"
    redirect_to :action => "login"
  end

  def change_price
    @now_price = Price.find(:first).price
    if request.post?
      @price = Price.find(:first)
      @price.price = params[:new_price]
      if @price.save
        flash[:notice] = t(:price_changed)
        redirect_to :action => "index"
      else
        flash[:notice] = t(:user_didnt_create)
      end
    end
  end

end
