class SessionsController < ApplicationController
  skip_before_filter :require_login
  def new
  end
  #Code juggling FTL :(
  def create
    @email = params[:email]
    @password = params[:password]
    @user = User.where(email: "#{@email}").first
    if (@user && @user.authenticate(@password))#are authenticated...
        session[:user_id] = @user.id
        redirect_to root_url, notice: 'Logged in!'
    else
        flash.now.alert = 'Invalid email or password'
        redirect_to root_url
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Logged out!'
  end

  def login
    @user = User.find(params[:id])
    session[:user_id] = @user.id
    redirect_to root_url, notice: 'Logged in!'
  end
end
