# frozen_string_literal: true

class UserSetting::Operation::UnblockCustomer < Operation::Base
  def perform!(user:, params:)
    authorize!(:customers, :edit?)

    update_user_settings(params)
  end

  private

  def update_user_settings(params)
    User.find(params[:format]).user_setting.update!(status: 0, comment: nil)
  end
end
