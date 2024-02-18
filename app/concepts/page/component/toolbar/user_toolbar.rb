# frozen_string_literal: true

class Page::Component::Toolbar::UserToolbar < ViewComponent::Base
  def initialize(user, user_type)
    @user = user
    @user_type = user_type
  end
end
