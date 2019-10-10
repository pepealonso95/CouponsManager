# frozen_string_literal: true

class UsersController < ApplicationController
  def new; end

  def create; end

  def update; end

  def edit; end

  def destroy; end

  def index
    @users = User.all
  end
end
