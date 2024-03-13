# frozen_string_literal: true

class Employee::Component::Show < ViewComponent::Base
  def initialize(model:)
    @user = model[:user]
    @employee = model[:employee]
  end
end
