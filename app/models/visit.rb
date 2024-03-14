# frozen_string_literal: true

class Visit < ApplicationRecord
  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id'
  belongs_to :employee, class_name: 'User', foreign_key: 'employee_id'

  enum payment_status: { delayed: 0, finished: 1 }

  validates :visitor, :employee, :payment_status, :visit_date, presence: true

  scope :with_conclusion, -> { where.not(conclusion: nil) }
  scope :future_employee_visits, ->(user) { where(employee_id: user.id, conclusion: nil) }
end
