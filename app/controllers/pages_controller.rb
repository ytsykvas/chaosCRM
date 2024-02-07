# frozen_string_literal: true

class PagesController < ApplicationController
  def index; end

  def profile
    @user = current_user if current_user.present?
  end
end
