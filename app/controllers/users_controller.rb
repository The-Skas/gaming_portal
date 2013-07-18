class UsersController < ApplicationController
  skip_before_filter :require_login
  def create
    @user = User.new(params[:user])
    if @user.save
        redirect_to "controller"=>"sessions", "action"=>"login", "format"=>"4", "id"=>"#{@user.id}"
    else
        render 'new'
    end
  end

  def new
    @user = User.new
  end

  def index

  end
end
