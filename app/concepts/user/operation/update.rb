# frozen_string_literal: true

class User::Operation::Update < Operation::Base
  def perform!(user:, params:)
    authorize!(:users, :update?)

    update_user(params)
  end

  private

  def update_user(params)
    User.find(params[:id]).update!(params_to_update(params))
  end

  def params_to_update(params)
    params.require(:user).permit(:first_name, :last_name, :phone, :email, :account_type).to_h
  end
end
