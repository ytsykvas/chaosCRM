# frozen_string_literal: true

class Visit < ApplicationRecord
  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id'
  belongs_to :employee, class_name: 'User', foreign_key: 'employee_id'

  enum payment_status: { delayed: 0, finished: 1 }

  validates :visitor, :employee, :payment_status, :visit_date, presence: true
end
