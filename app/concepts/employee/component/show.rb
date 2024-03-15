# frozen_string_literal: true

class Employee::Component::Show < ViewComponent::Base
  def initialize(model:)
    @employee = model[:employee]
    @today_visits = model[:visits][:today_visits]
    @without_conclusion = model[:visits][:without_conclusion]
  end
end
