class UsersController < ApplicationController
  def new
  end

  def create
  end

  def update
  end

  def edit
  end

  def destroy
  end

  
  def index
    @users = User.all
  end

  def show
    @user = User.find(id_param)
  end
end
