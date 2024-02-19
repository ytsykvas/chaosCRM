# frozen_string_literal: true

class UsersPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      raise Pundit::NotDefinedError, 'You cannot see this page'
    end
  end

  def update?
    user&.admin?
  end
end
