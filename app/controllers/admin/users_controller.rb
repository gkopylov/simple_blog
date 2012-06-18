class Admin::UsersController < ApplicationController

  def index
    @users = User.order('created_at DESC').page params[:page]
  end

end
