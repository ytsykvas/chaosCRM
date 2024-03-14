# frozen_string_literal: true

class Component::TitleBack < ViewComponent::Base
  def initialize(title:, back_path:, button_text: nil)
    @title = title
    @back_path = back_path
    @button_text = button_text
  end
end
