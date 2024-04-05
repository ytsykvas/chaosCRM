# frozen_string_literal: true

class Visit::Component::Index < ViewComponent::Base
  def initialize(model)
    @visits = model[:model][:all_visits]
    @customer = model[:model][:user_with_visits]
  end
end
