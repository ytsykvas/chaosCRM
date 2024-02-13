# frozen_string_literal: true

class UserSetting < ApplicationRecord
  belongs_to :user

  enum status: { active: 0, banned: 1 }
  enum language: { ua: 0, en: 1 }

  validates :status, presence: true
  validates :language, presence: true
end
