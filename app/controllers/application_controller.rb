# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include OperationsMethods

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  helper_method :current_user, :logged_in?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def change_locale_to_en
    I18n.default_locale = :en

    redirect_back(fallback_location: root_path)
  end

  def change_locale_to_uk
    I18n.default_locale = :uk

    redirect_back(fallback_location: root_path)
  end

  def logged_in?
    !!current_user
  end

  protected

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore
    flash[:alert] = t "#{policy_name}.#{exception.query}", scope: 'pundit', default: :default
    redirect_to root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name phone])
  end
end
