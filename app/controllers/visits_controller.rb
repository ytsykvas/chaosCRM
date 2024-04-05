# frozen_string_literal: true

class VisitsController < ApplicationController
  def index
    endpoint Visit::Operation::Index, Visit::Component::Index
  end
end
