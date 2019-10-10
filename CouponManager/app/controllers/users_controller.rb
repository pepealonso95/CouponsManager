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

  def show
    @user = User.find(current_user.id)
  end

  def index
    @users = User.all
  end
end
