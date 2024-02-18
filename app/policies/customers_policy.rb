# frozen_string_literal: true

class CustomersPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      raise Pundit::NotDefinedError, 'You cannot see this page'
    end
  end

  def index?
    user&.admin?
  end

  def show?
    user&.admin? || user&.employee?
  end
end
