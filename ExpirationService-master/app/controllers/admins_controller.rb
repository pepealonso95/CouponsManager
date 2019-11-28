class AdminsController < ApplicationController
  skip_before_action :verify_authenticity_token
    def index
      @admins = Admin.all
    end

    def addAdmin
        adminEmail = request.headers['email']
        adminName = request.headers['name']
        Admin.create(name: adminName, email: adminEmail)
        render json: { status: adminEmail }, status: :ok

    end




  end