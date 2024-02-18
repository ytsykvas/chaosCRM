# frozen_string_literal: true

class Page::Operation::Profile < Operation::Base
  def perform!(user:, **)
    self.model = user
  end
end
