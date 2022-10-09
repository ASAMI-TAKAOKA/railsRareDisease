class ApplicationController < ActionController::Base
  before_action :configure_sign_up_parameters, if: :devise_controller?
  # RailsにおけるCSRF対策
  protect_from_forgery with: :exception
  include SessionsHelper

  protected
    def configure_sign_up_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
    end

    def after_sign_out_path_for(resource)
      root_path
    end
end
