class ApplicationController < ActionController::Base
    set_current_tenant_through_filter
    before_action :authenticate_user!
  
    before_action :set_tenant
  
    def set_tenant
      set_current_tenant(current_user.organization) if current_user.present?
    end

    def is_admin?
      redirect_to "" unless current_user.role==0
    end
    
    def is_logged_out?
      redirect_to "" unless !user_signed_in?
    end
end
