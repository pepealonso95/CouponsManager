class ApplicationController < ActionController::Base
    set_current_tenant_through_filter
  
    before_action :set_tenant
  
    def set_tenant
      set_current_tenant(current_user.organization) if current_user.present?
    end
end
