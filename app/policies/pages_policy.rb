# frozen_string_literal: true

class PagesPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      raise Pundit::NotDefinedError, '1111111'
    end
  end

  def profile?
    user.present?
  end
end
