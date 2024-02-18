# frozen_string_literal: true

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]

  def index
    render Page::Component::Index.new
  end

  def profile
    endpoint Page::Operation::Profile, Page::Component::Profile
  end
end
