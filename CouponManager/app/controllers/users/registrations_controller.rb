# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  skip_before_action :authenticate_user!, only: [:create_non_admin, :edit_non_admin, :complete_non_admin_registration]
  # before_action :is_logged_out? , only: [:edit_non_admin, :complete_non_admin_registration]
  # before_action :authenticate_user! , only: [:create_non_admin]
  # before_action :is_admin?, only: [:create_non_admin]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  def create_non_admin
    non_admin = User.new(name: 'default_name', lastname: 'default_lastname', password: 'default_password', email: params[:email], organization_id: current_user.organization_id, role: 1)
    non_admin.confirmation_token = SecureRandom.urlsafe_base64
    if non_admin.save
      UserMailer.non_admin_registration(non_admin).deliver
      # logger.info "Successfully added a non admin user: #{non_admin.email}"
    else
      # logger.info "Unsuccessfully added a non admin user. #{non_admin.errors.full_messages}"
      flash['notice'] = "Error: #{non_admin.errors.full_messages}"
    end
    redirect_to ''
  end

  def edit_non_admin
    @user = User.where('confirmation_token = :confirmation_token', confirmation_token: params[:token]).first
    if @user
      # logger.info "Non Admin User is completing his registration"
      @organization = Organization.find(@user.organization_id)
      render '/devise/registrations/edit_not_admin.erb'
    else
      # logger.info "No User that has not completed registration with that confirmation token"
      redirect_to '/users/sign_in'
    end
  end

  def complete_non_admin_registration
    # params[:user][:confirmed_at] = Time.now
    token = params[:user][:confirmation_token]
    @user = User.where('confirmation_token = :confirmation_token', confirmation_token: token).first
    if @user
      params[:user][:confirmation_token] = SecureRandom.urlsafe_base64
      if @user.update_attributes(non_admin_params)
        flash['alert'] = 'ENTRO'
        redirect_to controller: 'users/registrations', action: 'edit_non_admin', token: token
        # logger.info "Non Admin User completed registration succesfully"
        # redirect_to "/users/sign_in"
      else
        # logger.info "Non Admin User could not complete registration successfully, redirecting"
        @organization = Organization.find(@user.organization_id)
        flash['alert'] = 'All fields must be filled'
        redirect_to controller: 'users/registrations', action: 'edit_non_admin', token: token
      end
    else
      flash['alert'] = 'NO WENTTR'
      redirect_to controller: 'users/registrations', action: 'edit_non_admin', token: token
      # logger.info "No User that has not completed registration with that confirmation token"
      # redirect_to "/users/sign_in"
    end
  end
  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name lastname organization_id avatar])
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  def non_admin_params
    params.require(:user).permit(:password, :name, :lastname, :confirmation_token)
  end
end
