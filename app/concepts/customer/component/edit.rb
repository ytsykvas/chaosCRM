# frozen_string_literal: true

class Customer::Component::Edit < ViewComponent::Base
  def initialize(model:)
    @customer = model[:customer]
  end

  def account_types
    {
      'visitor' => t('customers.edit.account_types.visitor'),
      'employee' => t('customers.edit.account_types.employee'),
      'admin' => t('customers.edit.account_types.admin')
    }
  end
end
