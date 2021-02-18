class ApplicationController < ActionController::Base
  # before_action :authenticate_user!
  
  # TO allow username be stored at signup
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end
end
