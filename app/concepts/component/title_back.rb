# frozen_string_literal: true

class Component::TitleBack < ViewComponent::Base
  def initialize(title:, back_path:)
    @title = title
    @back_path = back_path
  end
end
