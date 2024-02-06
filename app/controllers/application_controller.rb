# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def change_locale_to_en
    I18n.default_locale = :en

    redirect_back(fallback_location: root_path)
  end

  def change_locale_to_uk
    I18n.default_locale = :uk

    redirect_back(fallback_location: root_path)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name phone])
  end
end
