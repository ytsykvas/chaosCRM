# frozen_string_literal: true

class Employee::Component::Show < ViewComponent::Base
  def initialize(model:)
    @employee = model[:employee]
    @total_visits = model[:visits][:total_visits]
    @today_visits = model[:visits][:today_visits]
  end
end
