class UsersController < ApplicationController
  before_filter :authorize
  
  def index
    @users = User.find(:all, :order => "username DESC")
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new params[:user]
    if @user.save
      flash[:notice] = t(:user_created)
      redirect_to :action => "index"
    else
      flash[:notice] = t(:user_didnt_create)
      redirect_to :action => "new"
    end
  end

  def delete
    @user = User.find params[:id]
    @user.destroy
    redirect_to :action => "index"
  end
end
