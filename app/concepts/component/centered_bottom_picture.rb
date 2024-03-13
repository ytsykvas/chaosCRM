# frozen_string_literal: true

class Component::CenteredBottomPicture < ViewComponent::Base
  def initialize(path:, alt_text: 'statue-picture')
    @path = path
    @alt_text = alt_text
  end
end
