# frozen_string_literal: true

class EmployeesPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      raise Pundit::NotDefinedError, 'You cannot see this page'
    end
  end

  def index?
    user&.admin?
  end

  def show?
    user&.admin?
  end

  def edit?
    user&.admin?
  end
end
