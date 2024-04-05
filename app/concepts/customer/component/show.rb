# frozen_string_literal: true

class Customer::Component::Show < ViewComponent::Base
  def initialize(model:)
    @user = model[:user]
    @customer = model[:customer]
    @visits = model[:visits]
    @today_visits = model[:visits].where("DATE(visit_date) = ?", Date.today)
    @account_status = @customer.user_setting&.status
  end
end
