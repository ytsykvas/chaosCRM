class CustomersPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      raise Pundit::NotDefinedError, "You cannot see this page. You are not an admin."
    end
  end

  def customers?
    user.admin?
  end
end
