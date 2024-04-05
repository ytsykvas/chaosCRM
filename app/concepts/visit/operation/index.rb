# frozen_string_literal: true

class Visit::Operation::Index < Operation::Base
  def perform!(user:, params:, **)
    authorize!(:visits, :index?)

    user_with_visits = User.find(params[:id])
    if user.account_type == 'employee' && user_with_visits.account_type == 'employee'
      authorize!(:visits, :employee_and_employee?) unless valid_users?(user, user_with_visits)
    end
    
    if user_with_visits.admin? || user_with_visits.employee?
      all_visits = user_with_visits.visits_as_employee
    elsif user_with_visits.visitor?
      all_visits = user_with_visits.visits_as_customer
    end

    self.model = {
      user:,
      user_with_visits:,
      all_visits: all_visits.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    }
  end

  private

  def valid_users?(user, user_with_visits)
    false if user.id != user_with_visits.id
  end
end
