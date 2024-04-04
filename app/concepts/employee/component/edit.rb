# frozen_string_literal: true

class Employee::Component::Edit < ViewComponent::Base
  def initialize(model:)
    @employee = model[:employee]
  end
end
