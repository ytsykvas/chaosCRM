# frozen_string_literal: true

class Customer::Operation::Edit < Operation::Base
  def perform!(user:, params:)
    authorize!(:customers, :edit?)
    customer = User.find(params[:id])

    self.model = {
      customer: customer
    }
  end
end
