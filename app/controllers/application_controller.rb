class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  before_action :update_allowed_parameters, if: :devise_controller?

  before_action :set_current_user
  before_action :set_ability
  def set_ability
    @ability = Ability.new(current_user)
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || users_path
  end

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:name, :email, :bio, :photo, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:name, :email, :bio, :photo, :password, :current_password)
    end
  end

  private

  def set_current_user
    @current_user = current_user
  end
end
