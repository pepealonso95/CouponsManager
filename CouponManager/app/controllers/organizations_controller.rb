class OrganizationsController < ApplicationController
  # include EventEmitter
  before_action :is_admin?, only: [:new, :create, :update, :edit, :destroy]

  def new
    @organization = Organization.new
  end

  
  def create
    @organization = Organization.new(organization_params)
    if @organization.save
      redirect_to organizations_path
    else
      render :new
    end
  end

  def update
    @organization = Organization.find(id_param)
    if @organization.update(edit_organization_params)
      redirect_to organizations_path
    else
      render :edit
    end
  end

  def edit
    @organization = Organization.find(id_param)
  end

  def destroy
    @organization = Organization.find(id_param)
    if @organization.destroy
      redirect_to organizations_path
    end
  end

  def index
    @organizations = Organization.all
  end


  def show
    @organization = Organization.find(id_param)
  end

  private

  def edit_organization_params
    params.require(:organization).permit(:name, :email)
  end

  def organization_params
    params.require(:organization).permit(:name, :email, :password)
  end

  def id_param
    params.require(:id)
  end

end
