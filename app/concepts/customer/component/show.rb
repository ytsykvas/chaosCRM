# frozen_string_literal: true

class Customer::Component::Show < ViewComponent::Base
  def initialize(model:)
    @user = model[:user]
    @customer = model[:customer]
    @visits = model[:visits]
  end
end
