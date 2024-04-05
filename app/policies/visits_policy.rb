# frozen_string_literal: true

class VisitsPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      raise Pundit::NotDefinedError, 'You cannot see this page'
    end
  end

  def index?
    user&.admin? || user&.employee?
  end

  def employee_and_employee?
    user&.admin?
  end
end
