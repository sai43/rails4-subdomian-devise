class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  include UrlHelper 
  before_action :check_subdomain
  before_action :authenticate_user!
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name,:email, :password, :password_confirmation, :role) }
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:name,:email, :password, :password_confirmation, :role)
    end
  end
    def after_sign_up_path_for(resource)
      signed_in_root_path(resource)
    end

    def after_update_path_for(resource)
      signed_in_root_path(resource)
    end

     def after_sign_in_path_for(resource)
      root_url(:subdomain => resource.role.subdomain)
      signed_in_root_path(resource)
     end

def check_subdomain
   unless request.subdomain == resource.role.name
    redirect_to root_path, alert: "You are not authorized to access that subdomain."
   end
end
    
end
