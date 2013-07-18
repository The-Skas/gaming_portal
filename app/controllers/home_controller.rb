class HomeController < ApplicationController
  skip_before_filter :require_login
  def index
  end

  def register
    @register = true
    @user = User.new
    render 'index'
  end
end
