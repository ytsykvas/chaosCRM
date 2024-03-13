# frozen_string_literal: true

class Employee::Component::Index < ViewComponent::Base
  def initialize(model:)
    @employees = model[:employees]
  end
end
