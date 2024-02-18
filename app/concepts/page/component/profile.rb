# frozen_string_literal: true

class Page::Component::Profile < ViewComponent::Base
  def initialize(model)
    @user = model[:model]
    @user_type = model[:model].account_type
  end
end
