# frozen_string_literal: true

class UserSetting::Operation::BlockCustomer < Operation::Base
  def perform!(user:, params:)
    authorize!(:customers, :edit?)

    update_user_settings(params)
  end

  private

  def update_user_settings(params)
    comment = params['user_setting']['comment']
    user = params['user_setting']['user_id']
    User.find(user).user_setting.update!(status: 1, comment: comment.strip) if comment.present?
  end
end
