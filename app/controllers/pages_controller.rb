# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :authorise_user, only: :profile

  def index; end

  def profile
    @user = current_user if current_user.present?
  end

  private

  def authorise_user
    authorize :pages, :profile?
  end
end
